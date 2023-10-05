
#configure provider

provider "aws" {
  region = var.region
}

module "CLL-VPC" {
  source                    = "../module"
  region                    = var.region
  project_name              = var.project_name
  vpc_cidr                  = var.vpc_cidr
  instance_tenancy          = var.instance_tenancy
  enable_dns_hostnames      = var.enable_dns_hostnames
  enable_dns_support        = var.enable_dns_support
  map_public_ip_on_launch   = var.map_public_ip_on_launch
  web-public_subnets_cidrs  = var.web-public_subnets_cidrs
  app-private_subnets_cidrs = var.app-private_subnets_cidrs
  app-private_subnets_name  = var.app-private_subnets_name
  web-Public_subnets_name   = var.web-Public_subnets_name
  
  
  #INSTANCE
  instance_type        = var.instance_type
  key_pair             = var.key_pair
  instance_count       = var.instance_count
  iam_instance_profile = var.iam_instance_profile
  Public-server_name   = var.Public-server_name
  Private-server_name  = var.Private-server_name
#security group
port-1  = var.port-1
port-1-description = var.port-1-description
  #RDS
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  db_name              = var.db_name
  username             = var.username
  allocated_storage    = var.allocated_storage
  parameter_group_name = var.parameter_group_name
  password             = var.password
  skip_final_snapshot  = var.skip_final_snapshot

}


