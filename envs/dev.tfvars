environment = "dev"
aws_profile = "vegait"
region = "eu-central-1"
tags = {
  owner = "milan.rakic"
  environment = "dev"
}

# S3
bucket_name = "student-terraform-learning-mr-2026-02-05"

# IAM
iam_user_name = "test-student-dev"
iam_custom_policy_name = "TestCustomBucketAccessPolicy"
security_group_name = "terraform-learning-sg"
security_group_description = "Security group description (dev)"

# EC2
instance_type = "t2.micro"
instance_name = "test-instance-dev"
instance_key_name = "mrakic-dev"

# VPC
vpc_cidr = "10.0.0.0/16"
subnet_cidr = "10.0.1.0/24"
private_subnets = ["10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
availability_zone = "eu-central-1a"
vpc_name = "mr-vpc-dev"

# Lambda
lambda_name = "lambda-example-dev"
lambda_handler = "lambda_function.handler"
lambda_runtime = "python3.11"
lambda_timeout = 10
lambda_memory = 128