terraform {
  required_version = ">= 0.13"
}

data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}
resource "aws_iam_role" "lambda_role" {
  name               = "lambda-lambdaRole-waf"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

variable "my_python_version" {
  type    = string
  default = "python3.6"
}


data "archive_file" "terraform_module" {
  for_each = {
    lambda_1 = var.lambda_1
    lambda_2 = var.lambda_2
  }
  type        = "zip"
  source_file = "../../lambda_functions/lambda_function.py"
  output_path = "${each.value}.zip"
}

resource "aws_lambda_function" "terraform_module" {
  for_each = {
    lambda_1 = var.lambda_1
    lambda_2 = var.lambda_2
  }
  function_name    = each.value
  filename         = "${each.value}.zip"
  source_code_hash = data.archive_file.terraform_module[each.key].output_base64sha256
  role             = aws_iam_role.lambda_role.arn
  runtime          = var.my_python_version
  handler          = "lambda_function.lambda_handler"
  timeout          = 10
}

