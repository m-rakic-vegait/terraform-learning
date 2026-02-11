output "mr_user_arn" {
  description = "ARN of created iam user"
  value = aws_iam_user.mr_user.arn
}

output "db_password" {
  value     = var.task_6_db_password
  sensitive = true
}