terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.44.0"
    }
  }
}

provider "aws" {
 region = "ap-south-1"
}

module "s3" {
  source         = "./modules/s3_bucket"
  s3_bucket_name = "rachakonda-dev-terraform-state"
}


module "dynamodb_table" {
  source              = "./modules/dynamodb_table"
  dynamodb_table_name = "rachakonda-dev-terraform-dynamodb-table"
}
