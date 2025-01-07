terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.81.0"
    }
  }
}

provider "aws" {
  region="ap-southeast-1"
}

resource "aws_instance" "myserver" {
    ami = "ami-0995922d49dc9a17d"
  instance_type = "t2.micro"
  tags = {
    Name ="myserrver"
  }
}