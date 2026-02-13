variable "region" {
  type = string
  description = "AWS Region"
}

variable "aws_profile" {
  type = string
  description = "The name of aws profile"
}

variable "instance_type" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "instance_key_name" {
  type = string
}