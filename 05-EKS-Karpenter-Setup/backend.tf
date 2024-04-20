terraform {
  backend "s3" {
    bucket         = "rachakonda-dev-terraform-state"
    key            = "state/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    kms_key_id     = "alias/terraform_kms_key"
    dynamodb_table = "rachakonda-dev-terraform-dynamodb-table"
  }
}