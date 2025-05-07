module "dev-infra" {
  source                = "./infra-app"
  env                   = "dev"
  bucket_name           = "Dev-bucket-for infra"
  sg-incoming-port-01   = 22
  sg-incoming-port-02   = 80
  sg-incoming-port-03   = 443
  ec2_ami_id            = "ami-0df01373d14375bb9"
  instance_type         = "t2.micro"
  ec2_root_storage      = 20
  ec2_root_storage_type = "gp3"
  Instance-count        = 1
  hash_key              = "UserId"
}
module "Stg-infra" {
  source                = "./infra-app"
  env                   = "stg"
  bucket_name           = "Stg-bucket-for infra"
  sg-incoming-port-01   = 22
  sg-incoming-port-02   = 80
  sg-incoming-port-03   = 443
  ec2_ami_id            = "ami-0df01373d14375bb9"
  instance_type         = "t2.small"
  ec2_root_storage      = 20
  ec2_root_storage_type = "gp3"
  Instance-count        = 1
  hash_key              = "UserId"
}
module "Prod-infra" {
  source                = "./infra-app"
  env                   = "prd"
  bucket_name           = "Prod-bucket-for infra"
  sg-incoming-port-01   = 22
  sg-incoming-port-02   = 80
  sg-incoming-port-03   = 443
  ec2_ami_id            = "ami-0df01373d14375bb9"
  instance_type         = "t2.medium"
  ec2_root_storage      = 20
  ec2_root_storage_type = "gp3"
  Instance-count        = 2
  hash_key              = "UserId"
}