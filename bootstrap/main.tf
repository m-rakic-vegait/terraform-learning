locals {
  tags = {
    project = "terraform-learning"
    section = "boostrap"
    owner = "test-user"
  }
}

# S3 bucket for state
resource "aws_s3_bucket" "tf_state_bucket" {
  bucket = var.tf_state_bucket_name

  lifecycle {
    prevent_destroy = true
  }

  tags = local.tags
}

# Versioning
resource "aws_s3_bucket_versioning" "tf_state_versioning" {
  bucket = aws_s3_bucket.tf_state_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state_encryption" {
  bucket = aws_s3_bucket.tf_state_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block public access
resource "aws_s3_bucket_public_access_block" "tf_state_access" {
  bucket = aws_s3_bucket.tf_state_bucket.id

  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

# DynamoDB for locking
resource "aws_dynamodb_table" "tf_locks_table" {
  name         = var.tf_lock_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = local.tags
}