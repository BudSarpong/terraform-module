
output "region" {

  value = var.region
}
output "project_name" {
  value = var.project_name
}
output "vpc_id" {
  value = aws_vpc.CLL-VPC.id
}
output "vpc_cidr" {
  value = var.vpc_cidr
}
output "instance_tenancy" {
  value = var.instance_tenancy
}
output "enable_dns_hostnames" {
  value = var.enable_dns_hostnames
}
output "enable_dns_support" {
  value = var.enable_dns_support
}
output "map_public_ip_on_launch" {
  value = var.map_public_ip_on_launch
}
output "web-public_subnets_name" {
  value = var.web-Public_subnets_name
}
output "app-private_subnets-name" {
  value =var.app-private_subnets_name
}
output "web-public_subnets_cidrs" {
  value = var.web-public_subnets_cidrs
}
output "app-private_subnets_cidrs" {
  value = var.app-private_subnets_cidrs
}




output "igw_id" {
  value = aws_internet_gateway.igw.id
}

#az
output "availabile_zone_1" {
  value = data.aws_availability_zones.available_zones.names[0]
}
output "availabile_zone_2" {
  value = data.aws_availability_zones.available_zones.names[1]
}
output "availabile_zone_3" {
  value = data.aws_availability_zones.available_zones.names[2]
}


#INSTANCE
output "instance_type" {
  value = var.instance_type
}
output "key_pair" {
  value = var.key_pair
}
output "instance_count" {
  value = var.instance_count
}
output "iam_instance_profile" {
  value = var.iam_instance_profile
}
output "Public-server_name" {
  value = var.Public-server_name
}
output "Private-server_name" {
  value = var.Private-server_name
}

#SECURITY GROUP
output "vpc_security_group_ids" {
  value = aws_security_group.tfsg_group.id
}
#ingress
output "port-1" {
 value = var.port-1 
}
output "port-1-description" {
  value = var.port-1-description
}


#RDS
output "engine" {
  value = var.engine
}
output "engine_version" {
  value = var.engine 
}
output "instance_class" {
  value = var.instance_class
}
output "db_name-" {
  value = var.db_name

}
output "username" {
  value = var.username
}
output "allocated_storage" {
  value = var.allocated_storage
}
output "parameter_group_name" {
  value = var.parameter_group_name
}
output "password" {
  value = var.password
}
output "skip_final_snapshot" {
  value = var.skip_final_snapshot
}


