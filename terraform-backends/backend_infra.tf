resource "aws_s3_bucket" "my_buck-p" {
    bucket = var.aws_s3_bucket
    tags = {
        Name = var.aws_s3_bucket

    }
}
resource "aws_dynamodb_table" "my_dynamo_table" {
     name  = var.aws_dynamodb_table
     billing_mode = "PAY_PER_REQUEST"
     hash_key = "LockID"

    attribute {
    name = "LockID"
    type = "S"
  }
    tags = {
        Name = var.aws_dynamodb_table
    }
}
