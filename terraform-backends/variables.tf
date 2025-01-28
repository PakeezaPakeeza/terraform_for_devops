variable "aws_region" {
    description = "aws region"
    default = "eu-central-1"
}
variable "aws_s3_bucket" {
    description = "aws backend bucket"
    default = "tws-junnon-state-p"
}

variable "aws_dynamodb_table" {
    description = "aws backend dynamodb table"
    default = "tws-junoon-state-table"
}