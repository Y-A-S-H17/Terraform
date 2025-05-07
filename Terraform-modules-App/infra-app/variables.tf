variable "env" {
  description = "This is for Environment for my infra-"
  type        = string
}
variable "bucket_name" {
  description = "This is Bucket name for my infra-"
  type        = string
}
#Three port Number we have to any way give
variable "sg-incoming-port-01" {
  description = "This is Port Number to open for my infra-"
  type        = number
  #22-ssh
}
variable "sg-incoming-port-02" {
  description = "This is Port Number to open for my infra-"
  type        = number
  #80-http
}
variable "sg-incoming-port-03" {
  description = "This is Port Number to open for my infra-"
  type        = number
  #443-https
}
variable "ec2_ami_id" {
  description = "This is my ami id For Ec2 machines"
  type        = string
}
variable "instance_type" {
  description = "This is my instance type for Ec2 machine"
  type        = string
}
variable "ec2_root_storage" {
  description = "This is my ec2_storage"
  type        = number
}
variable "ec2_root_storage_type" {
  description = "This is my storage type for ec2"
  type        = string
}
variable "Instance-count" {
  description = "This is Instance-count"
  type        = number
}
variable "hash_key" {
  description = "This is hash for the dynamodb table"
  type        = string

}
