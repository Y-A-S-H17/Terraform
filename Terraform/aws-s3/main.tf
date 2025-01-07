terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.81.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

provider "aws" {
  region="ap-southeast-1"
}
resource "random_id" "random_id" {
    byte_length = 8
}
resource "aws_s3_bucket" "mybucket" {
    bucket = "mybuckte-${random_id.random_id.hex}" 
}
output "aws_s3_bucket" {
    value = aws_s3_bucket.mybucket.bucket
}

resource "aws_s3_object" "bucket-data" {
    bucket = aws_s3_bucket.mybucket
    source = "./data.txt"
    key = "mydata.txt"
  
}