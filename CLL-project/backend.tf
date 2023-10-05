#store the terraform state file in s3 bucket

terraform {
  backend "s3" {
    bucket = "terraformmodule103"
    dynamodb_table = "CLL-dm"
    key    = "terraform.tfstate"
    encrypt = true
    region = "eu-west-2"

  }
}

/*backend "s3" {
    bucket =
    key    =
    region =
    dynamodb_table =
    encrypt =
}




resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket"
versioning {
    enabled = true
}
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }

}


resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "GameScores"
  billing_mode   = "PROVISIONED"
  hash_key       = "UserId"
  
  attribute {
    name = "UserId"
    type = "S"
  }
}*/
