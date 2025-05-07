variable "ec2_instance_type" {
  default = "t2.micro"
  type    = string
}
variable "ec2_ami_id" {
  default = "ami-0f1dcc636b69a6438" #amazon linux
  type    = string
}
variable "ec2_root_storage" {
  default = 20
  type    = number
}
variable "ec2_root_storage_type" {
  default = "gp3"
  type    = string
}
variable "env" {
  default = "prd"
  type    = string

}
