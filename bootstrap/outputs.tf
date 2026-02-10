output "tf_state_bucket_id" {
  description = "The ID of bucket"
  value = aws_s3_bucket.tf_state_bucket.id
}

output "tf_locks_table_id" {
  description = "The ID of DynamoDB table for state locking"
  value = aws_dynamodb_table.tf_locks_table.id
}