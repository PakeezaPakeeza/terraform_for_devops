terraform {
  backend "s3" {
    bucket = "workspacebysaikiran"
    key    = "functions.tfstate"
    region = "us-east-1"
  }
}
