# Lambda function for zip
data "archive_file" "lambda_zip" {
  type = "zip"
  source_dir = "${path.module}"
  output_path = "${path.module}/lambda.zip"
}

# 5.1. Create Python Lambda function that returns event data
resource "aws_lambda_function" "this" {
  function_name = var.lambda_name
  handler = var.lambda_handler
  runtime = var.lambda_runtime
  role = aws_iam_role.lambda_exec.arn
  filename = data.archive_file.lambda_zip.output_path
  source_code_hash = filebase64sha256(data.archive_file.lambda_zip.output_path)
  timeout = var.lambda_timeout
  memory_size = var.lambda_memory
  environment {
    variables = {
      ENV = var.environment
    }
  }
}

# 5.2. IAM role for Lambda with trust policy
resource "aws_iam_role" "lambda_exec" {
  name = "${var.lambda_name}-exec-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# 5.4. Attach created role for CloudWatch logs
resource "aws_iam_role_policy_attachment" "lambda_basic_logs" {
  role = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# 5.5. API Gateway (REST API)
# REST API
resource "aws_api_gateway_rest_api" "this" {
  name = "${var.lambda_name}-api"
  endpoint_configuration {
    types = [ "REGIONAL" ]
  }
}
# Route
resource "aws_api_gateway_resource" "trigger" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id = aws_api_gateway_rest_api.this.root_resource_id
  path_part = "trigger"
}
# Method
resource "aws_api_gateway_method" "trigger_get" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.trigger.id
  http_method = "GET"
  authorization = "NONE"
}
# Integration
resource "aws_api_gateway_integration" "trigger_lambda" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.trigger.id
  http_method = aws_api_gateway_method.trigger_get.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = aws_lambda_function.this.invoke_arn
}
# Permission
resource "aws_lambda_permission" "allow_apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.this.execution_arn}/*/*"
}

# 6. CloudWatch integration - Set up log groups and monitoring
resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${aws_lambda_function.this.function_name}"
  retention_in_days = 14

  tags = merge(
    var.tags,
    { name = "${var.lambda_name}-integration" }
  )
}
