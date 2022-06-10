data "archive_file" "python_lambda_package" {
  type        = "zip"
  source_file = "../../lambda_functions/lambda_function_2.py"
  output_path = "nametest_2.zip"
}

resource "aws_lambda_function" "test_lambda_function" {
  function_name    = "lambdaTest2"
  filename         = "nametest_2.zip"
  source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
  role             = aws_iam_role.lambda_role.arn
  runtime          = "python3.6"
  handler          = "lambda_function.lambda_handler"
  timeout          = 10
}