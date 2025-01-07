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
locals {
  project =project-01
}
resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "${local.project}-vpc"
    }
  
}
#public subnet using count
resource "aws_subnet" "main" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.${count.index}.0/24"
    count = 2
    tags = {
      Name = "${local.project}-subnet-${count.index}"
    }
  
}
resource "aws_instance" "main" {
    #using count
    #ami = var.ec2_config[count.index].ami
    #instance_type = var.ec2_config[count.index].instance_type
    #count = 4

    for_each = var.ec2_map
    ami = each.value.ami
    instance_type = each.value.instance_type
    subnet_id = element(aws_subnet.main[*].id,index( keys(var.ec2_map)),each.key) %length(aws_subnet.main)
    #using count
    #subnet_id = element(aws_subnet.main[*].id, count.index % length(aws_subnet.main))
    #0%2=0
    #1%2=1
    tags = {
      Name = "${local.project}-instance-${each.key}"
    }
    
}
output "aws_subnet" {
    value = aws_subnet.main[1].id
  
}