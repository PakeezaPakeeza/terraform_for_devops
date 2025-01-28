# data resource k through hum ny vpc , subnet(acc to our wish ku k hmary pas 3 thy), and SG fetch kerna hai ku k ec2 ki requirement thi

data "aws_vpc" "terraform-aws-testing" {
  id = "vpc-05df93ed7fd2f3243"
}
data "aws_subnet" "Terraform_Public_Subnet1-testing" {
  id = "subnet-0c8e655674f49b697"
}

data "aws_security_group" "allow_all" {
  id = "sg-0f28fbef9b510316f"
}
