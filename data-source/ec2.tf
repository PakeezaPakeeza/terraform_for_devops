#hmaray aws region(north virginia() mein ek vpc bana hua hai ,, hum ny uski info ko data k through use ker k ek ec2 banana hai
#using data-source to access networking components in terraform

resource "aws_instance" "web-1" {
     #ami = "${data.aws_ami.my_ami.id}"
     ami = "ami-0e2c8caa4b6378d8c"
     availability_zone = "us-east-1a"
     instance_type = "t2.micro"
     key_name = "n.virginia-key"   #.pem nahi lagana
     subnet_id = data.aws_subnet.Terraform_Public_Subnet1-testing.id
     vpc_security_group_ids = [data.aws_security_group.allow_all.id]
     associate_public_ip_address = true	
     tags = {
         Name = "Server-1"
         Env = "Prod"
         Owner = "sai"
 	CostCenter = "ABCD"
     }
} 
#now i want to copy this current state file also into my s3 bucket
terraform {
  backend "s3" {
    bucket = "cloudbysaikiran"
    key    = "base-infra-with-ec2.tfstate"
    region = "eu-central-1"
  }
}