provider "aws" {
}
#trivy:ignore:AVD-AWS-0086
#trivy:ignore:AVD-AWS-0087
#trivy:ignore:AVD-AWS-0088
#trivy:ignore:AVD-AWS-0089
#trivy:ignore:AVD-AWS-0090
#trivy:ignore:AVD-AWS-0091
#trivy:ignore:AVD-AWS-0093
#trivy:ignore:AVD-AWS-0094
#trivy:ignore:AVD-AWS-0132
resource "aws_s3_bucket" "test" {
  #checkov:skip=CKV2_AWS_6
  #checkov:skip=CKV2_AWS_62
  #checkov:skip=CKV2_AWS_61
  #checkov:skip=CKV_AWS_144
  #checkov:skip=CKV_AWS_145
  #checkov:skip=CKV_AWS_21
  #checkov:skip=CKV_AWS_18
  bucket = "bucket"
  
}
