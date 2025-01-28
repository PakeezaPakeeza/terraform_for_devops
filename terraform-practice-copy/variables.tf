#variable word k agy koi b word likh skty hain or default k ander b apki merzi ka naam ata hai 
variable "aws_region" {
    description = "This is the regionspecified for aws region"
    default = "eu-central-1"
}
#variable "aws_ec2_ami_id" {
 #   description = "This is AMI id for ubuntu instance "
  #  default = "ami-0a628e1e89aaedf80"
#}
variable "aws_ec2_instance_type" {
    description = "this is the instance type for EC2 instance"
    default = "t2.micro"
} 
variable "aws_ec2_instance_name" {
    description = "this is the instance name given to ec2 instance"
    default = "test-server-p"
}
variable aws_root_volume_size {
    description ="this is the root volume size for ec2 instance"
    default = "11"
}
variable "aws_instance_count" {
    default = "1"
    description = "the count of ec2 instances needed"
}