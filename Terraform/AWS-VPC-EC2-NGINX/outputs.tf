output "instance-Public-ip" {
    description = "The public of the ec2 address"
    value = aws_instance.niginx.public_ip
  
}
output "access-url" {
    description = "The public of the ec2 address"
    value = "hhtp://${aws_instance.niginx.public_ip}"
  
}
