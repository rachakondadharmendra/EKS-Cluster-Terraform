resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = var.s3_bucket_name 
  
  force_destroy = true

  lifecycle {
    prevent_destroy = false
  } 

}

resource "aws_s3_bucket_public_access_block" "block" {
 bucket = aws_s3_bucket.terraform_state_bucket.id

 block_public_acls       = true
 block_public_policy     = true
 ignore_public_acls      = true
 restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "terraform_bucket_versioning" {
  bucket = aws_s3_bucket.terraform_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_kms_key" "terraform_kms_key-alias" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_kms_alias" "terraform_kms_key-alias" {
 name          = "alias/terraform_kms_key"
 target_key_id = aws_kms_key.terraform_kms_key-alias.key_id
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_server_side_encryption_conf" {
  bucket = aws_s3_bucket.terraform_state_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.terraform_kms_key-alias.arn
      sse_algorithm     = "aws:kms"
    }
  }
}