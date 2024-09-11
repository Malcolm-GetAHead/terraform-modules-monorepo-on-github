resource "null_resource" "test" {
  count    = 1
  triggers = { a = "b" }
}

terraform {
  required_version = "~> 1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.60.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.2"
    }
  }
}

provider "aws" {
}
