variable "environment" {
  type = string
  description = "Current environment"
}

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

variable "tags" {
  type = map(string)
  description = "Tags for resources"
}