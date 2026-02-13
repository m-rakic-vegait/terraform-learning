variable "region" {
  type = string
  description = "AWS Region"
}

variable "aws_profile" {
  type = string
  description = "The name of aws profile"
}

variable "vpc_name" {
  type = string
  description = "VPC name"
}

variable "vpc_cidr" {
  type = string
  description = "CIDR block for the VPC"
}

variable "public_subnet" {
  type = string
  description = "CIDR block for the public subnet"
}

variable "private_subnets" {
  type = list(string)
  description = "The list of SIDR blocks for private subnets"
}

variable "availability_zone" {
  type = string
  description = "AWS Availability Zone for the subnet"
}