resource "aws_dynamodb_table" "remote_backen_s3" {
  name         = "terraform-state-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  range_key    = "GameTitle"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "dynamodb-table-1"
  }
}