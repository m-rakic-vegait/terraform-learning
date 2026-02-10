# Terraform Bootstrap

This module creates:
- S3 bucket for Terraform remote state
- DynamoDB table for state locking

Run once per AWS account.

## Usage

cd bootstrap_folder
terraform init
terraform apply