
data "archive_file" "myLambda2" {

  type        = "zip"
  source_file = "../lambda_functions/lambda_function_dynamo.py"
  output_path = "lambda_zip.zip"
}

resource "aws_lambda_function" "myLambda2" {

  function_name    = "firstFunction2"
  filename         = "lambda_zip.zip"
  source_code_hash = data.archive_file.myLambda2.output_base64sha256
  role             = aws_iam_role.lambda_role2.arn
  runtime          = var.my_python_version
  handler          = "lambda_function_dynamo.lambda_handler"
  timeout          = 10
}

# IAM role which dictates what other AWS services the Lambda function
# may access.
resource "aws_iam_role" "lambda_role2" {
  name = "role_lambda2"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

output "invoke_arn" {
  value = aws_lambda_function.myLambda2.invoke_arn
}

output "lambda_name_us" {
  value = aws_lambda_function.myLambda2.function_name
}

output "iam_role_out" {
  value = aws_iam_role.lambda_role2.id
}