terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "tws-junnon-state-p"
    key = "terraform.tfstate"
    region = "eu-central-1"
    dynamodb_table = "tws-junoon-state-table"
  }
}
# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}