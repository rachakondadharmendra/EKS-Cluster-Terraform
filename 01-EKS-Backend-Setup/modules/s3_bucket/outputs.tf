output "s3_bucket_name" {
  description = "S3 Bucket Name"
  value       = aws_s3_bucket.terraform_state_bucket.id
}