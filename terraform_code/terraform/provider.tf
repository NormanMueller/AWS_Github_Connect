locals {
  my_python_version = "python3.6"
  my_aws_region     = "eu-central-1"
}

terraform {
  required_version = ">= 0.13"
  backend "s3" {
    bucket         = "terraform-up-and-running-state-nm-test"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-central-1"
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
  region = local.my_aws_region
}

