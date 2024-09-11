terraform {
  required_version = "~> 1.9.0"
}

resource "aws_s3_bucket" "test" {
  bucket = "bucket"
}
