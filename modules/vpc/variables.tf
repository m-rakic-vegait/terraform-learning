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

variable "tags" {
  type = map(string)
  description = "Tags for resources"
}
