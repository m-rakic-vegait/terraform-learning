locals {
  env = terraform.workspace
  default_instance_type = "t3.micro"

  instance_type_by_env = {
    dev = "t3.micro"
    prod = "t3.small"
  }

  instance_type = lookup(
    instance_type_by_env,
    local.env,
    local.default_instance_type
  )

  task_6_tags = {
    project = "task-6"
    environment = local.env
    owner = "m.r."
  }
}