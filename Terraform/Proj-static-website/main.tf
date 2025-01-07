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
resource "aws_s3_bucket" "mywebapp" {
    bucket = "mywebapp-${random_id.random_id.hex}" 
}
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.mywebapp.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "mywebapp_policy" {
   bucket = aws_s3_bucket.mywebapp.id
   policy = jsonencode( 
    {
    Version = "2012-10-17",
    Statement = [
        {
            Sid = "PublicReadGetObject",
            Effect = "Allow",
            Principal = "*",
            Action = "s3:GetObject"
            Resource = "arn:aws:s3:::${aws_s3_bucket.mywebapp.id}/*"
        }
    ]
})

}

resource "aws_s3_bucket_website_configuration" "webapp" {
  bucket = aws_s3_bucket.mywebapp

  index_document {
    suffix = "index.html"
  }
}
resource "aws_s3_object" "index_html" {
    bucket = aws_s3_bucket.mywebapp
    source = "./index.html"
    key = "index.html"
    content_type = "text/html"
}
resource "aws_s3_object" "style_css" {
    bucket = aws_s3_bucket.mywebapp
    source = "./index.html"
    key = "style.css"
    content_type = "text/css"
}
output "aws_s3_bucket" {
    value = aws_s3_bucket_website_configuration.webapp.website_endpoint
}