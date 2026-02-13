locals {
  tags = {
    project = "terraform-learning/network"
    task = "task-6"
    owner = "milan.rakic"
  }
}

module "vpc_task_6" {
  source = "../../modules/vpc"
  vpc_cidr = var.vpc_cidr
  public_subnet = var.public_subnet
  private_subnets = var.private_subnets
  availability_zone = var.availability_zone
  vpc_name = var.vpc_name
  tags = local.tags
}