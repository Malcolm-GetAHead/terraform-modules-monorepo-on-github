resource "null_resource" "test" {
  count    = 1
  triggers = { a = "b" }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.60.0"
    }
  }
}

provider "aws" {
}

resource "aws_fake_resource" "name" {
  name = "fake"
}
