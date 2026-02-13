provider "aws" {
  region = var.region
}

# 2.6. Local values - Use locals block for reusable values across resources
locals {
  tags = {
    project = "terraform-learning"
    owner = "test-user"
    environment = var.environment
  }
}

# 1.2. Create S3 bucket
resource "aws_s3_bucket" "mr_bucket" {
  bucket = var.bucket_name
  tags = merge(
    var.tags,
    { name = "bucket-${var.bucket_name}" }
  )
}

# 1.3. Add versioning
resource "aws_s3_bucket_versioning" "mr_versioning" {
  bucket = var.bucket_name
  versioning_configuration {
    status = "Enabled"
  }
}

# 1.4. Apply bucket policy
# -- Enable creating policies
resource "aws_s3_bucket_public_access_block" "mr_bucket_access" {
  bucket = aws_s3_bucket.mr_bucket.id
  block_public_acls = false
  block_public_policy = false
  restrict_public_buckets = false
  ignore_public_acls = false
}
# -- Define policy allowing public read access to bucket objects
data "aws_iam_policy_document" "mr_public_policy" {
  statement {
    sid = "PublicReadGetObject"
    effect = "Allow"
    principals {
      type = "*"
      identifiers = [ "*" ]
    }
    actions = [ "s3:GetObject" ]
    resources = [ "arn:aws:s3:::${aws_s3_bucket.mr_bucket.id}/*" ]
  }
}
# -- Attach policy to the bucket
resource "aws_s3_bucket_policy" "mr_public_access_bucket_policy" {
  bucket = aws_s3_bucket.mr_bucket.id
  policy = data.aws_iam_policy_document.mr_public_policy.json
}

# Destroy all from task 1 with 'destroy' command...

# 2.1. Create IAM user
resource "aws_iam_user" "mr_user" {
  name = var.iam_user_name
  tags = merge(
    var.tags,
    { name = "user-${var.iam_user_name}" }
  )
}

# 2.2. Reference AWS managed S3ReadOnlyAccess policy
data "aws_iam_policy" "mr_s3readonly" {
  arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  tags = merge(
    var.tags,
    { name = "aws-policy-AmazonS3ReadOnlyAccess" }
  )
}

# 2.3. Create custom policy
resource "aws_iam_policy" "mr_custom" {
  name = var.iam_custom_policy_name
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:Get*",
        "s3:List*",
        "s3:Describe*",
        "s3-object-lambda:Get*",
        "s3-object-lambda:List*"
      ],
      "Resource": [
        "arn:aws:s3:::${aws_s3_bucket.mr_bucket.id}-*",
        "arn:aws:s3:::${aws_s3_bucket.mr_bucket.id}-*/*"
      ]
    }
  ]
}
EOF

  tags = merge(
    var.tags,
    { name = "custom-policy-${var.iam_custom_policy_name}" }
  )
}

# 2.4. Attach both policies
# -- AWS managed policy
resource "aws_iam_user_policy_attachment" "mr_attach_readonly" {
  user = aws_iam_user.mr_user.name
  policy_arn = data.aws_iam_policy.mr_s3readonly.arn
}
# -- Custom policy
resource "aws_iam_user_policy_attachment" "mr_attach_custom" {
  user = aws_iam_user.mr_user.name
  policy_arn = aws_iam_policy.mr_custom.arn
}

# 2.5. Output values - Export user ARN and relevant information
output "mr_attached_policy_arns" {
  value = [
    aws_iam_user_policy_attachment.mr_attach_readonly.policy_arn,
    aws_iam_user_policy_attachment.mr_attach_custom.policy_arn,
  ]
}

# 3.1. Define variables - Create variables for instance type, key pair name, environment tags
# Defined in variables.tf

# 3.2. Dynamic AMI lookup - Use data sources to automatically find latest Amazon Linux AMI
data "aws_ami" "amazon-linux" {
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-x86_64-gp2" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
}

# 4. VPC
module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  public_subnet = var.subnet_cidr
  private_subnets = var.private_subnets
  availability_zone = var.availability_zone
  vpc_name = var.vpc_name
  tags = local.tags
}

# 3.3. Create security group - Build security group named terraform-learning-sg with SSH access
module "mr_security_group" {
  source = "terraform-aws-modules/security-group/aws"
  name = var.security_group_name
  description = var.security_group_description
  vpc_id = module.vpc.vpc_id
  ingress_with_cidr_blocks = [
    {
      description = "SSH From"
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = var.subnet_cidr
    }
  ]
  egress_with_cidr_blocks = [
    {
      description = "Allow outbound internet"
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = merge(
    var.tags,
    { name = "security-group-${var.security_group_name}" }
  )
}

# 3.4. Launch instance - Deploy t2.micro EC2 instance using variables and data sources
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  name = var.instance_name
  instance_type = var.instance_type
  key_name      = var.instance_key_name
  monitoring    = true
  ami = data.aws_ami.amazon-linux.id
  security_group_name = module.mr_security_group.security_group_name
  subnet_id = module.vpc.subnet_id

  tags = merge(
    var.tags,
    { name = "ec2-${var.instance_name}" }
  )
}

# 3.5. Conditional logic - Use count or for_each for optional resource creation
# Create EC2 using condition
module "ec2_instance_optional" {
  count = var.create_optional_ec2 ? 1 : 0
  source  = "terraform-aws-modules/ec2-instance/aws"
  name = var.optional_instance_name
  instance_type = var.instance_type
  key_name      = var.optional_instance_key_name
  monitoring    = true
  ami = data.aws_ami.amazon-linux.id
  security_group_name = module.mr_security_group.security_group_name
  subnet_id = module.vpc.subnet_id

  tags = merge(
    var.tags,
    { name = "ec2-${var.optional_instance_name}" }
  )
}

# 3.6. Variable validation - Add validation rules and descriptions for input variables
# Added in variables.tf for mr_instance_type

# 3.7. Multiple environments - Use .tfvars files for dev/prod configurations
# Added env.tfvars and prod.tfvars in envs folder

# 5. Serverless Infrastructure with Lambda
module "lambda_mr" {
  source = "./modules/lambda_api"
  lambda_name = var.lambda_name
  lambda_handler = var.lambda_handler
  lambda_runtime = var.lambda_runtime
  lambda_timeout = var.lambda_timeout
  lambda_memory = var.lambda_memory
  tags = local.tags
  environment = var.environment
}
