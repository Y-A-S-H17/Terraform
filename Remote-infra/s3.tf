resource "aws_s3_bucket" "remote_s3" {
  bucket = "terraform-remote-backup-bucket-01"

  tags = {
    Name = "My bucket"
  }
}