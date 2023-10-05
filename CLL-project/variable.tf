

#VPC
variable "region" {}
variable "project_name" {}
variable "vpc_cidr" {}
variable "instance_tenancy" {}
variable "app-private_subnets_cidrs" {}
variable "web-public_subnets_cidrs" {}
variable "enable_dns_hostnames" {}
variable "enable_dns_support" {}
variable "map_public_ip_on_launch" {}
variable "web-Public_subnets_name" {}
variable "app-private_subnets_name" {}

#INSTANCE
variable "instance_type" {}
variable "key_pair" {}
variable "instance_count" {}
variable "iam_instance_profile" {}
variable "Public-server_name" {}
variable "Private-server_name" {}
#security group
variable "port-1" {}
variable "port-1-description" {}

#RDS
variable "allocated_storage" {}
variable "db_name" {}
variable "engine" {}
variable "engine_version" {}
variable "instance_class" {}
variable "username" {}
variable "password" {}
variable "parameter_group_name" {}
variable "skip_final_snapshot" {}

