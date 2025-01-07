ec2_config = [ {
  ami = "ami-06650ca7ed78ff6fa"
  instance_type = "t2.micro"
},
{
    ami = "ami-0995922d49dc9a17d"
    instance_type = "t2.micro"
} ]

ec2_map = {
  "ubuntu" = {
    ami = "ami-06650ca7ed78ff6fa"
    instance_type = "t2.micro"
    
  },
  "amazon-linux"={
    ami = "ami-0995922d49dc9a17d"
    instance_type = "t2.micro"
  }
}