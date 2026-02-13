environment = "prod"
aws_profile = "vegait"
region = "eu-central-1"
tags = {
  owner = "milan.rakic"
  environment = "prod"
}

# S3
bucket_name = "student-terraform-learning-mr-2026-02-05"

# IAM
iam_user_name = "test-student-prod"
iam_custom_policy_name = "TestCustomBucketAccessPolicy"
security_group_name = "terraform-learning-sg"
security_group_description = "Security group description (prod)"

# EC2
instance_type = "t2.micro"
instance_name = "test-instance-prod"
instance_key_name = "mrakic-prod"
create_optional_ec2 = false
optional_instance_name = "optional-test-instance-prod"
optional_instance_key_name = "optional-mrakic-prod"

# VPC
vpc_cidr = "10.0.0.0/16"
subnet_cidr = "10.0.1.0/24"
private_subnets = ["10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
availability_zone = "eu-central-1a"
vpc_name = "mr-vpc-prod"

# Lambda
lambda_name = "lambda-example-prod"
lambda_handler = "lambda_function.handler"
lambda_runtime = "python3.11"
lambda_timeout = 10
lambda_memory = 128

# # State Management
# dynamodb_table_name = "task-6-tf-locks-prod"
# db_password = "dbsecret"
# task_6_public_subnet_cidr_block = "10.2.111.0/24"
# task_6_private_subnet_cidr_blocks = ["10.2.112.0/24", "10.2.113.0/24", "10.2.114.0/24"]
# task_6_availability_zone = "eu-central-1b"
# task_6_security_group_name = "task-6-sg-prod"
# task_6_security_group_description = "Task 6 security group description (prod)"
# task_6_vpc_cidr = "10.2.0.0/16"
# task_6_vpc_name = "task-6-vpc-prod"
# task_6_instance_name = "task-6-instance-prod"
# task_6_instance_key_name = "task-6-instance-key-name-prod"