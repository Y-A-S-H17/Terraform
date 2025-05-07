resource "aws_key_pair" "Infra-key" {
  key_name   = "${var.env}-Infra-key"
  public_key = file("terra-key.pub")
  tags = {
    name        = "${var.env}-Infra-key"
    Environment = var.env
  }
}
resource "aws_default_vpc" "myvpc" {

}

resource "aws_security_group" "mysg" {
  name   = "${var.env}-Infra-app-sg"
  vpc_id = aws_default_vpc.myvpc.id #stringinterpolation
  #default
  ingress {
    from_port   = var.sg-incoming-port-01
    to_port     = var.sg-incoming-port-01
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "ssh-Port-Open"
  }
  ingress {
    from_port   = var.sg-incoming-port-02
    to_port     = var.sg-incoming-port-02
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP-Port-Open"
  }
  ingress {
    from_port   = var.sg-incoming-port-03
    to_port     = var.sg-incoming-port-03
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
    name        = "${var.env}-sg"
    Environment = var.env
  }

}

#instance details
resource "aws_instance" "terra-sever" {
  count                  = var.Instance-count
  ami                    = var.ec2_ami_id    #amazon linux
  instance_type          = var.instance_type #var.ec2_instance_type
  key_name               = aws_key_pair.Infra-key.key_name
  vpc_security_group_ids = [aws_default_vpc.myvpc.id]
  security_groups        = [aws_security_group.mysg.id]

  #root volume attach
  root_block_device {
    #using env
    volume_size = var.env == "prd" ? 30 : var.ec2_root_storage
    volume_type = var.ec2_root_storage_type
  }

  tags = {
    name        = "${var.env}-instance"
    Environment = var.env
  }
}