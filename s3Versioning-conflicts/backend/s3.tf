#console mein jo bucket hai usko bnaty hoye versioning enable ker lein

resource "aws_s3_bucket" "mybucket" {
  bucket = "cloudbysaikiran"

  tags = {
    Name        = "cloudbysaikiran"
    Environment = "Dev"
  }
}