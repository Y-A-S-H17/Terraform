resource "random_id" "random_id" {
    byte_length = 6
  
}
variable "mybucket" {
    default = "01-uat-business.web.com@12"
    type = string
}
