#VPC

resource "aws_vpc" "CLL-VPC" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags = {
    Name = "${var.project_name}-vpc"
  }
}



#AVAILABILITY ZONE


# use data source to get all avalablility zones in region
data "aws_availability_zones" "available_zones" {}



#SUBNETS

#WEB-PUBLIC-SUBNETS


resource "aws_subnet" "web-public_subnets" {
 count                    = length(var.web-public_subnets_cidrs)
  vpc_id                  = aws_vpc.CLL-VPC.id
  cidr_block              = var.web-public_subnets_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = {
    Name = var.web-Public_subnets_name[count.index]
  }
}



#APP-PRIVATE-SUBNETS

resource "aws_subnet" "app-private_subnets" {
 count                    = length(var.app-private_subnets_cidrs)
  vpc_id                  = aws_vpc.CLL-VPC.id
  cidr_block              = var.app-private_subnets_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = {
    Name = var.app-private_subnets_name[count.index]
  }
}







#ROUTE-TABLES


resource "aws_route_table" "web-public_route" {
  vpc_id = aws_vpc.CLL-VPC.id
 
tags = {
    Name = "${var.project_name}-web-public_route"
  }
}

resource "aws_route_table" "app-private_route" {
  vpc_id = aws_vpc.CLL-VPC.id
   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }
tags = {
    Name = "${var.project_name}-app-private_route"
  }
}




#ROUTE-TABLE-ASSOCIATIONS




resource "aws_route_table_association" "web-public-assosition" {
 count           = length(var.web-public_subnets_cidrs)
  subnet_id      = aws_subnet.web-public_subnets[count.index].id
  route_table_id = aws_route_table.web-public_route.id
}

resource "aws_route_table_association" "app-private-assosition" {
 count           = length(var.app-private_subnets_cidrs)
  subnet_id      = aws_subnet.app-private_subnets[count.index].id
  route_table_id = aws_route_table.app-private_route.id
}


#IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.CLL-VPC.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

#ROUTE-IGW

resource "aws_route" "CLL-route-igw" {
  route_table_id         = aws_route_table.web-public_route.id
  gateway_id             = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"


}

#EIP

resource "aws_eip" "elastic-eip" {


}


#NGW

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.elastic-eip.id
  subnet_id     = aws_subnet.web-public_subnets[0].id

  tags = {
    Name = "${var.project_name}-ngw"
  }

}




# Security groups.(Dynamic block)
locals {
  ingress_rules = [{

    port        =var.port-1 
    description = var.port-1-description
    },
    {
      port        = 22
    description = "ssh"
    },
    {
      port        = 3306
    description = "rds"
  }]

  egress_rules = [{

    port        = 0
    description = "port 0"
  }]
}



resource "aws_security_group" "tfsg_group" {
  name   = "tfsg_group"
  vpc_id = aws_vpc.CLL-VPC.id

  dynamic "ingress" {
    for_each = local.ingress_rules

    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]

    }
  }

  dynamic "egress" {
    for_each = local.egress_rules

    content {
      description = egress.value.description
      from_port   = egress.value.port
      to_port     = egress.value.port
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]

    }
  }

}

#2 (t2.micro) Servers to be placed in public and 2 to be in the private subnets. Please ensure to use
#the count.index or element() function to help with the number of server creation per configuration. 

#INSTANCE



data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "Public-server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
   subnet_id             = aws_subnet.web-public_subnets[count.index].id
  key_name               = var.key_pair
  count                  = var.instance_count
  iam_instance_profile   = var.iam_instance_profile
  vpc_security_group_ids = [aws_security_group.tfsg_group.id]
  tags = {
    Name = var.Public-server_name[count.index]
  }
}
 
resource "aws_instance" "Private-server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.app-private_subnets[count.index].id
  key_name               = var.key_pair
  count                  = var.instance_count
  iam_instance_profile   = var.iam_instance_profile
  vpc_security_group_ids = [aws_security_group.tfsg_group.id]
  tags = {
    Name = var.Private-server_name[count.index]
  }
}


#RDS
resource "aws_db_subnet_group" "dbs_subnet" {
  subnet_ids = [aws_subnet.app-private_subnets[0].id , aws_subnet.web-public_subnets[0].id ]

  tags = {
    Name = "dbs_subnet"
  }
}


resource "aws_db_instance" "CLL" {
  allocated_storage    = var.allocated_storage
  db_name              = var.db_name
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  db_subnet_group_name = aws_db_subnet_group.dbs_subnet.name

  port                   = 3306
  password               = var.password
  parameter_group_name   = var.parameter_group_name
  skip_final_snapshot    = var.skip_final_snapshot
  vpc_security_group_ids = [aws_security_group.tfsg_group.id]
  availability_zone      = data.aws_availability_zones.available_zones.names[0]
}





