#This Terraform Code Deploys Basic VPC Infra.
provider "aws" {
  # access_key = "${var.aws_access_key}"
  # secret_key = "${var.aws_secret_key}"
  region = var.aws_region
}
terraform {
  backend "s3" {
    bucket = "workspacebysaikiran"
    key    = "workspace.statefile"
    region = "us-east-1"
  }
}


resource "aws_vpc" "default" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name  = "${var.vpc_name}"
    Owner = "Saikiran"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
  tags = {
    Name = "${var.IGW_name}"
  }
}

resource "aws_subnet" "subnet1-public" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.public_subnet1_cidr
  availability_zone = "us-east-1a"

  tags = {
    Name = "${var.public_subnet1_name}"
  }
}

resource "aws_subnet" "subnet2-public" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.public_subnet2_cidr
  availability_zone = "us-east-1b"

  tags = {
    Name = "${var.public_subnet2_name}"
  }
}

resource "aws_subnet" "subnet3-public" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.public_subnet3_cidr
  availability_zone = "us-east-1c"

  tags = {
    Name = "${var.public_subnet3_name}"
  }

}


resource "aws_route_table" "terraform-public" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = {
    Name = "${var.Main_Routing_Table}"
  }
}

resource "aws_route_table_association" "terraform-public" {
  subnet_id      = aws_subnet.subnet1-public.id
  route_table_id = aws_route_table.terraform-public.id
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#workspcaes need ?
#terraform apply --var-file .\dev.tfvars or .\stg.tfvars create only one statefile or override the existing statefile
#now if we want to craete teh same infra in 3 different enviornmnets then we need workspaces 
#terraform workspace list
#terraform workspace new dev
#terraform workspace new uat
#terrfaorm workspace select dev
#terraform init
#terraform plan --var-file .\dev.tfvars
#terraform worksspace select uat
#terraform init
#terraform plan --var-file .\uat.tfvars
#terraform destroy --var-file .\uat.tfvars   destroy kerny k liye same env mein hona must hai
#to delete workspace -------> apko owrkspace sy bahar ana ho ga
#terrfaorm workspace select default
#terraform workspace delete dev