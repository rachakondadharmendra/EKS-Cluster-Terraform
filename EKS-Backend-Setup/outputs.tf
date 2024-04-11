output "dynamodb_table_name" {
  description = "DynamoDB Table Name"
  value       = module.dynamodb_table.dynamodb_table_name
}

output "s3_bucket_name" {
  description = "S3 Bucket Name"
  value       = module.s3.s3_bucket_name
}
