output "network_vpc_id" {
  value = module.vpc_task_6.vpc_id
}

output "network_public_subnet_id" {
  value = module.vpc_task_6.subnet_id
}

output "network_private_subnets_id" {
  value = module.vpc_task_6.private_subnets_id
}