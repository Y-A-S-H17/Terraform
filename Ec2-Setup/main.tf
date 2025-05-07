terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.96.0"
    }
  }
  backend "s3" {
    bucket ="terraform-remote-backup-bucket-01"
    key="terraform.tfstate"
    region="us-east-1"
    dynamodb_table="terraform-state-table"
  }
}

provider "aws" {
  region = "us-east-1"
}

#Key Pair
resource "aws_key_pair" "deployer" {
  key_name   = "terra-key"
  public_key = file("terra-key.pub")
}
resource "aws_default_vpc" "myvpc" {

}

resource "aws_security_group" "mysg" {
  vpc_id = aws_default_vpc.myvpc.id #stringinterpolation
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "ssh-Port-Open"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP-Port-Open"
  }
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    name = "terra-sg"
  }

}


#ebs-volume
# resource "aws_ebs_volume" "volume-2" {
#     size = 30
#     tags = {
#     Name = "HelloWorld"
#   }
# }

#instance details
resource "aws_instance" "terra-sever" {
  for_each = tomap({
    "Web Server" = "t2.micro"
    "App Server" = "t3.micro"
  })
  ami                    = var.ec2_ami_id #amazon linux
  instance_type          = each.value     #var.ec2_instance_type
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_default_vpc.myvpc.id]
  security_groups        = [aws_security_group.mysg.id]
  user_data              = file("install.sh")


  #root volume attach
  root_block_device {
    #using env
    volume_size = var.env == "prd" ? 20 : var.ec2_root_storage
    volume_type = var.ec2_root_storage_type
  }

  tags = {
    name = each.key #"terra-server"
  }


}