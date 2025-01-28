#out put word k bad i think koi b word ho skta hai phir value k liye aws_instance my instance ap ny apni file sy resource sy lia or phir public_ip(default) word hai,jo terraform plan sy b mil jaye ga
output "ec2_public_ip" {
    value = aws_instance.my_instance[*].public_ip[*]
}
output "ec2_private_ip" {
    value = aws_instance.my_instance[*].private_ip[*]
}
