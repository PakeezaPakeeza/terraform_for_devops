#variables,count output with count,data,state_management ++ ---> locals,for each , output with for_each
#data block fetch the data for terraform
data "aws_ami" "os_image" {
    owners = ["767397899482"]
    most_recent = true
    filter {
        name = "state"
        values = ["available"]
    }
    filter {
        name = "name"
        values = ["ubuntu"]
    }
   }

#key-pair
resource aws_key_pair my_key {
    key_name = "terra-key-p"
    public_key = file("terra-key-p.pub")
}
#default-VPC
resource "aws_default_vpc" "default" {
    tags = {
        Name = "terra VPC"
  }
}
#security-group
resource "aws_security_group" "my-sg" {
    name = "my Z plus security"
    description = "this is a SG by TF"
    vpc_id = aws_default_vpc.default.id
    
    ingress {
        description = "allow access to SSH port 22"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "allow access to http port 80"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        description = "allow all out going traffic"
        to_port = 0
        from_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "my Z plus security"
    }
}
#is local mein instances k ander 2 key value pair hain so ye 2 instances banye ga
locals {
    instancep = {
        "key": "my_instance_1",
        "key2": "my_instance_2"
    }
}
#aws_instance
resource aws_instance my_instance{
    #count = var.aws_instance_count         #meta argument aur replicas banata hai
    for_each = local.instancep               #meta argument dono ek sath kam nahik ker skty count and for_each, instance for_each k sath create ho rehy hain
    instance_type = var.aws_ec2_instance_type
    ami = data.aws_ami.os_image.id
    key_name = aws_key_pair.my_key.key_name
    security_groups = [aws_security_group.my-sg.name] 
    #storage 
    root_block_device {
        volume_size = var.aws_root_volume_size
        volume_type = "gp3"
    }
    tags = {
        Name = each.value
    }
}

