resource "aws_iam_role" "lambda_role" {  
  name = "lambda-lambdaRole-waf"  
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}