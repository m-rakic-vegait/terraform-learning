provider "aws" {
  region = var.region
}

# 1.2. Create S3 bucket
resource "aws_s3_bucket" "mr_bucket" {
  bucket = var.bucket_name
  tags = var.tags
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
    resources = [ "arn:aws:s3::${var.bucket_name}/*" ]
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
  tags = var.tags
}

# 2.2. Reference AWS managed S3ReadOnlyAccess policy
data "aws_iam_policy" "mr_s3readonly" {
  arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  tags = var.tags
}

# 2.3. Create custom policy
resource "aws_iam_policy" "mr_custom" {
  name = var.iam_custom_policy_name
  tags = var.tags
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
        "arn:aws:s3:::${var.bucket_name}-*",
        "arn:aws:s3:::${var.bucket_name}-*/*"
      ]
    }
  ]
}
EOF
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

# 2.6. Local values - Use locals block for reusable values across resources
# ...

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

# 3.3. Create security group - Build security group named terraform-learning-sg with SSH access
module "mr_security_group" {
  source = "terraform-aws-modules/security-group/aws"
  name = var.security_group_name
  description = var.security_group_description
  ingress_with_cidr_blocks = [
    {
      description = "SSH From"
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = var.mr_my_subnet
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
}

# 3.4. Launch instance - Deploy t2.micro EC2 instance using variables and data sources
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  name = var.mr_instance_name
  instance_type = var.mr_instance_type
  key_name      = "user1"
  monitoring    = true
  # subnet_id     = "my_subnet_id"

  tags = var.tags
}

# 3.5. Conditional logic - Use count or for_each for optional resource creation

# 3.6. Variable validation - Add validation rules and descriptions for input variables
# Added in variables.tf for mr_instance_type

# 3.7. Multiple environments - Use .tfvars files for dev/prod configurations
# Added env.tfvars and prod.tfvars in envs folder