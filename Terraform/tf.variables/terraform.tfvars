aws_instance_type = "t3.micro"
ec2_config = {
  volume_size = 30
  volume_type = "gp3"
}
additional_tags = {
    department = "QA"
    Project="MY-PROJECT"
}