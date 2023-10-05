
#vpc
region                    = "eu-west-2"
project_name              = "CLL"
vpc_cidr                  = "10.0.0.0/16"
instance_tenancy          = "default"

app-private_subnets_cidrs = ["10.0.12.0/24", "10.0.13.0/24"]
web-public_subnets_cidrs  = ["10.0.10.0/24", "10.0.11.0/24"]
web-Public_subnets_name   = ["web-public-subnet-1", "web-public-subnet-2"]
app-private_subnets_name  = ["app-private-subnet-1", "app-private-subnet-2"]

enable_dns_hostnames      = "true"
enable_dns_support        = "true"
map_public_ip_on_launch   = "true"

#instance
instance_type        = "t2.micro"
key_pair             = "awuah"
instance_count       = "2"
iam_instance_profile = "Budsarpong-port"
Public-server_name   = ["Public-server1", "Public-server2"]
Private-server_name  = ["Private-server1", "Private-server2"]
#security group
port-1        = 80
    port-1-description = "http"

#rds
allocated_storage    = "10"
db_name              = "cll"
engine               = "MySQL"
engine_version       = "5.7"
instance_class       = "db.t2.micro"
username             = "budsarpong103"
password             = "rdspassword"
parameter_group_name = "default.mysql5.7"
skip_final_snapshot  = "true"




