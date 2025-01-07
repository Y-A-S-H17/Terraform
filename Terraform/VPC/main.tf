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

resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "myvpc"
    }
  
}
#public subnet
resource "aws_subnet" "public_subnet" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.myvpc.id
    tags = {
      Name = "Public-subnet"
    }
  
}
#private_subnet
resource "aws_subnet" "private_subnet" {
    cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.myvpc.id
    tags = {
      Name = "Private-subnet"
    }
  
}
resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.myvpc.id
    tags = {
        Name = "myigw"
    } 
}
resource "aws_route_table" "my_rt" {
    vpc_id =  aws_vpc.myvpc.id
    route {
        cidr_block ="0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_igw.id
    }
}
resource "aws_route_table_association" "public-sub" {
    route_table_id = aws_route_table.my_rt.id
    subnet_id = aws_subnet.public_subnet.id
}

resource "aws_instance" "Yashserver" {
    ami = "ami-0995922d49dc9a17d"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public_subnet.id
    tags = {
        Name ="Yash_Sever"
  }
}