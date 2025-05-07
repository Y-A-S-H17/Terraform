resource "aws_dynamodb_table" "my-table" {
  name         = "${var.env}-state-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.hash_key
  attribute {
    name = var.hash_key
    type = "S"
  }

  tags = {
    Name        = "${var.env}-dynamodb-table-1"
    Environment = var.env
  }
}