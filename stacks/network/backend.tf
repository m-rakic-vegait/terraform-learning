terraform {
  backend "s3" {
    bucket = "tf-test-bucket-state-2026-02-10"
    region = "eu-central-1"
    dynamodb_table = "tf-test-locks"
    encrypt = true
    key = "network/terraform.tfstate"
    profile = "vegait"
  }
}