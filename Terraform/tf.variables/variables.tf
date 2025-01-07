variable "aws_instance_type" {
    description = "What type of instance you want to create?"
    type = string
    validation {
      condition = var.aws_instance_type =="t2.micro" || var.aws_instance_type =="t3.micro"
      error_message = "Only t2 and t3 mico allowed "
    }
}

#single variable
variable "root_volume_size" {
    type = number
    default = 20
}
variable "root_volume_type" {
    type = string
    default = "gp2"
}


#object created 
variable "ec2_config" {
    type = object({
      volume_size = number
      volume_type = string
    })
    default = {
      volume_size = 20
      volume_type = "gp2"
    }
  
}

#Tag Created
variable "additional_tags" {
  type = map(string)
}