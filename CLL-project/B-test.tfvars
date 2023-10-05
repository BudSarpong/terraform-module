region           = "eu-west-2"
project_name     = "website"
vpc_cidr         = "10.0.0.0/16"
instance_tenancy = "default"

app-private_subnets_cidrs = ["10.0.12.0/24", "10.0.13.0/24"]
web-public_subnets_cidrs  = ["10.0.10.0/24", "10.0.11.0/24"]

