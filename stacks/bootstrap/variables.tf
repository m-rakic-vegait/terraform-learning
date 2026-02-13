variable "region" {
  type    = string
  description = "AWS region"
}

variable "aws_profile" {
  type    = string
  description = "AWS profile"
}

variable "tf_state_bucket_name" {
  type = string
  description = "The name of tf state bucket"
}

variable "tf_lock_table_name" {
  type    = string
  description = "The name of DynamoDB table for state locking"
}