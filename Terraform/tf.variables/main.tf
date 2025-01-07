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

resource "aws_instance" "niginx" {
    ami = "ami-0995922d49dc9a17d"
    instance_type = "t2.micro"
    root_block_device {
      delete_on_termination = true
      volume_size = var.root_volume_size
      volume_type = var.ec2_config.volume_type
    }
    tags = merge(var.additional_tags)
        Name="sampler server"
}