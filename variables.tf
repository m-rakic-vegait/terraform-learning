variable "environment" {
  type = string
  description = "Environment"
  default = "dev"
}

variable "region" {
  type = string
  description = "AWS Region"
  default = "eu-central-1"
}

variable "tags" {
  type = object({
    name = string
    environment = string
  })
  validation {
    condition = contains(keys(var.tags), "name")
    error_message = "The key 'name' is required."
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

variable "mr_my_subnet" {
  type = string
  description = "My subnet"
}

variable "mr_instance_type" {
  type = string
  description = "EC2 Instance Type"
  validation {
    condition = contains(["t2.micro", "t2.small", "t2.medium", "t2.large"], var.mr_instance_type)
    error_message = "Only possible values for EC2 Instance type: t2.micro, t2.small, t2.medium, t2.large."
  }
}

variable "mr_instance_name" {
  type = string
}