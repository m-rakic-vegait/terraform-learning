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
create_optional_ec2 = true
optional_instance_name = "optional-test-instance-dev"
optional_instance_key_name = "optional-mrakic-dev"

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

# State Management
# task_6_dynamodb_table_name = "task-6-tf-locks-dev"
# task_6_db_password = "dbsecret"
# task_6_public_subnet_cidr_block = "10.1.111.0/24"
# task_6_private_subnet_cidr_blocks = ["10.1.112.0/24", "10.1.113.0/24", "10.1.114.0/24"]
# task_6_availability_zone = "eu-central-1b"
# task_6_security_group_name = "task-6-sg-dev"
# task_6_security_group_description = "Task 6 security group description (dev)"
# task_6_vpc_cidr = "10.1.0.0/16"
# task_6_vpc_name = "task-6-vpc-dev"
# task_6_instance_name = "task-6-instance-dev"
# task_6_instance_key_name = "task-6-instance-key-name-dev"