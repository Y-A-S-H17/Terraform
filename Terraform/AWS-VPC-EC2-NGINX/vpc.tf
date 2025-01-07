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