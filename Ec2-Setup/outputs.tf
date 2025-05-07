#output for count
# output "ec2_public_ip" {
#     value = aws_instance.terra-sever.public_ip
# }
# output "ec2_private_ip" {
#     value = aws_instance.terra-sever.private_ip
# }
# output "ec2_instance_dns" {
#     value = aws_instance.terra-sever.public_dns 

# }

#Output for each
output "ec2_public_ip" {
  value = [
    for instance in aws_instance.terra-sever : instance.public_ip
  ]

}
output "ec2_private_ip" {
  value = [
    for instance in aws_instance.terra-sever : instance.private_ip
  ]

}