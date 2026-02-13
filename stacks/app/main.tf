locals {
  tags = {
    project = "terraform-learning/app"
    task = "task-6"
    owner = "milan.rakic"
  }
}

data "aws_ami" "ami_linux_task_6" {
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

module "ec2_instance_task_6" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  name = var.instance_name
  instance_type = var.instance_type
  key_name      = var.instance_key_name
  monitoring    = true
  ami = data.aws_ami.ami_linux_task_6.id
  subnet_id = data.terraform_remote_state.network.outputs.network_public_subnet_id
  tags = local.tags
}