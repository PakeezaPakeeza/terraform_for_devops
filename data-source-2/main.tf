# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
#aws-VPC
resource "aws_vpc" "Vpc-Terraform" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_hostnames = "true"

  tags = {
    Name = "Vpc-Terraform"
  }
}
#aws-IG
resource "aws_internet_gateway" "Igw-Terraform" {
  vpc_id = aws_vpc.Vpc-Terraform.id

  tags = {
    Name = "Igw-Terra"
  }
}
#subnet
resource "aws_subnet" "Public-Subnet-Terraform" {
  vpc_id     = aws_vpc.Vpc-Terraform.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Public-Subnet-Terraform"
  }
}

#aws-RT
resource "aws_route_table" "Pub-RT-Terra" {
  vpc_id = aws_vpc.Vpc-Terraform.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Igw-Terraform.id
  }
  tags = {
    Name = "Pub-RT-Terra"
  }
}
# aws subnet association
resource "aws_route_table_association" "Pub-RTA-Terra" {
  subnet_id      = aws_subnet.Public-Subnet-Terraform.id
  route_table_id = aws_route_table.Pub-RT-Terra.id
}
#aws SG
resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.Vpc-Terraform.id

  ingress {
    from_port         = 0
    protocol       = "tcp"
    to_port           = 0
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port         = 0
    protocol       = "-1"
    to_port           = 0
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_all"
  }
}