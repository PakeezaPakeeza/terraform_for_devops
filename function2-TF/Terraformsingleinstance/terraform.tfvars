
aws_region = "us-east-1"
vpc_cidr = "172.18.0.0/16"
vpc_name = "Devsecops-Vpc"
key_name = "n.virginia-key"
azs = ["us-east-1a", "us-east-1b", "us-east-1c"]
instance_type = "t2.micro"
public_cidr_block = ["172.18.1.0/24", "172.18.2.0/24", "172.18.3.0/24"]
private_cidr_block = ["172.18.10.0/24", "172.18.20.0/24", "172.18.30.0/24"]
environment = "Dev"
#amis = "ami-0e2c8caa4b6378d8c"          #ye AMI sirf us-east-1 mein work kery gi or kahin nahi isliye hum map use keren gy multiple values k liye or using lookup function hum values retrive keren gy 
amis = {
    us-east-1 = "ami-0e2c8caa4b6378d8c"     #key,value
    use-east-2 = "ami-036841078a4b68e14"
}

