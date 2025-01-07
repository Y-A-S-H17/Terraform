terraform {}

locals {
  value = "Hello World"
}

variable "string_list" {
    type = list(string)
    default = [ "server1","server2","server3" ]
}
#remove # one by one to see below results
output "output" {
    #value = lower(local.value)
    #value = startswith(loacl.value,"Hello")
    #value = min( 1,2,3,4,5,6)
    #value = length(var.string_list)
    #value = join(":",var.string_list)
    value = toset(var.string_list)
}