terraform {
  required_version = ">= 0.13"
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "terraform-up-and-running-state-nm-test"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-central-1"
    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.5.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

