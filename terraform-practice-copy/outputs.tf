#values for loop sy nikalwany hoti hain is method mein
output "ec2_public_ip" {
    value = [
         for key, instancep  in aws_instance.my_instance: instancep.public_ip ]
}