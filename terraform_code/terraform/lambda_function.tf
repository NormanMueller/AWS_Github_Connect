data "archive_file" "python_lambda_package" {
  for_each = {
    lambda_1 = "lambda_test1"
    lambda_2 = "lambda_test2"
  }
  type        = "zip"
  source_file = "../../lambda_functions/lambda_function.py"
  output_path = "${each.value}.zip"
}

resource "aws_lambda_function" "test_lambda_function" {
  for_each = {
    lambda_1 = "lambda_test1"
    lambda_2 = "lambda_test2"
  }
  function_name    = each.key
  filename         = "${each.value}.zip"
  source_code_hash = data.archive_file.python_lambda_package[each.key].output_base64sha256
  role             = aws_iam_role.lambda_role.arn
  runtime          = var.my_python_version
  handler          = "lambda_function.lambda_handler"
  timeout          = 10
}

data "aws_lambda_function" "lambda_data" {
  function_name = "lambda_1"
}

output "bar" {
  value = data.aws_lambda_function.lambda_data.version
}