resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-up-and-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}


data "aws_s3_bucket" "table_data" {
  bucket = "terraform-up-and-running-state-nm-test"
}

output "foo" {
  value = data.aws_s3_bucket.table_data.id == "2" ? "yes" : "no"
}