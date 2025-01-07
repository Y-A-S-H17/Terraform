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

#to get caller id
data "aws_caller_identity" "name" {
  
}
output "aws_caller_identity" {
  value = data.aws_caller_identity.name
}


#ami
data "aws_ami" "name" {
  most_recent = true
  owners = [ "amazon" ]
}

output "aws_ami" {
    value = data.aws_ami.name
  
}

#az
data "aws_availability_zones" "name" {
  state= "availabelity"
}
output "aws_zones" {
  value = aws_availability_zones
}

#sg
data "aws_security_group" "name" {
    tags = {
        name = "http"
    }
  
}
output "aws_security_group" {
  value = data.aws_security_group.aws_security_group.id
}

#vpc
data "aws_vpc" "mypc" {
    tags = {
        name = "default"
    }
}
output "aws_vpc" {
    value = data.aws_vpc.mypc.id
  
}


resource "aws_instance" "Yashserver" {
    ami = "ami-0995922d49dc9a17d"
    instance_type = "t2.micro"
    tags = {
        Name ="Yash_Sever"
  }
}
