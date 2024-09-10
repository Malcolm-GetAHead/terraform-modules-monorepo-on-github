resource "null_resource" "test" {
  count    = 1
  triggers = { a = "b" }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.96.0"
    }
  }
}

provider "aws" {
}
