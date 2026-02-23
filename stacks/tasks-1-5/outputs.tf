output "mr_user_arn" {
  description = "ARN of created iam user"
  value = aws_iam_user.mr_user.arn
}

output "mr_attached_policy_arns" {
  value = [
    aws_iam_user_policy_attachment.mr_attach_readonly.policy_arn,
    aws_iam_user_policy_attachment.mr_attach_custom.policy_arn,
  ]
}