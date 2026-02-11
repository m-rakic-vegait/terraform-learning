variable "environment" {
  type = string
  description = "Environment"
}

variable "region" {
  type = string
  description = "AWS Region"
}

variable "aws_profile" {
  type = string
  description = "The name of aws profile"
}

variable "tags" {
  type = object({
    owner = string
    environment = string
  })
  validation {
    condition = contains(keys(var.tags), "owner")
    error_message = "The key 'owner' is required."
  }
  validation {
    condition = contains(keys(var.tags), "environment")
    error_message = "The key 'environment' is required."
  }
}

variable "bucket_name" {
  type = string
  description = "S3 bucket name"
}

variable "iam_user_name" {
  type = string
  description = "IAM user name"
}

variable "iam_custom_policy_name" {
  type = string
  description = "IAM custom policy name"
}

variable "security_group_name" {
  type = string
  description = "Name of security group with SSH access"
}

variable "security_group_description" {
  type = string
  description = "Description of security group with SSH access"
}

variable "instance_type" {
  type = string
  description = "EC2 Instance Type"
  validation {
    condition = contains(["t2.micro", "t2.small", "t2.medium", "t2.large"], var.instance_type)
    error_message = "Only possible values for EC2 Instance type: t2.micro, t2.small, t2.medium, t2.large."
  }
}

variable "instance_name" {
  type = string
}

variable "instance_key_name" {
  type = string
}

# VPC variables
variable "vpc_cidr" {
  type = string
  description = "CIDR block for the VPC"
}

# For the same purpose, different named variables are used in order to check usage.
# In root/main.tf, "subnet_cidr" variable is used.
# In modules/vpc/main.tf "public_subnet" variable is used.
variable "subnet_cidr" {
  type = string
  description = "CIDR block for the subnet"
}

variable "private_subnets" {
  type = list(string)
  description = "The list of private subnets"
}

variable "availability_zone" {
  type = string
  description = "AWS Availability Zone for the subnet"
}

variable "vpc_name" {
  type = string
  description = "VPC name"
}

# Lambda
variable "lambda_name" {
  type = string
  description = "The name of Lambda function"
}

variable "lambda_handler" {
  type = string
  description = "The handler of Lambda function"
}

variable "lambda_runtime" {
  type = string
  description = "The runtime of Lambda function"
}

variable "lambda_timeout" {
  type = string
  description = "The timeout of Lambda function"
}

variable "lambda_memory" {
  type = string
  description = "The memory of Lambda function"
}