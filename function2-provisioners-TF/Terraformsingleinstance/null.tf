#again ye ec2 k ander rekheun gy to TF modifications kerny py ec2 ko pehly terminate kery ga isliye hum null.tf bnayeb gy, or userrdata script chalyen gy
#step 1  ----> script update ho gai , ec2 mein , without turning it off butttttttttttttttttt
#--------------------------step2
#ager humny user data mein ab dobara koi modification ki, to wo  TF to us change ko record ker ly ga lekin real mein ec2 py userdata mein koi change ni ho ga
#user data change kerny k liye ec2 reboot kerna perta hai lekin wo hum nahi chahty ec2 band ho isliye null_resource k sath TF taint b use ho ga (yani resource recreate hoga) command pass keren gy e.g: terraform taint null_resource.cluster[0] 
#taint says i am going to destroy resources whatever you're tainting & when you're applying changes to it i will recreate it again, isliye null resources ko ec2 level k block py nahi rekha nahi to ec2 band hona tha
#ab hamary is case mein tainting kerny py, destination mein pera user-data.sh py changes ho jayen gi ku k , Tf  null_resource.cluster[0] ko recreation k liye consider kery ga !!! or terraform apply kerny py null_resources ko destroy ker k jo chezein us file mein add ki thi un changes ko apply ker dy ga
#commands to use    terraform state list    terraform taint null_resource.cluster[0 ]   terraform apply
resource "null_resource" "cluster"{
        count = "${var.environment == "Prod" ? 3 : 1}"
    #file provisioner to copy a file from local to the remote ec2 instance
        provisioner "file" {
        source      = "user-data.sh"
        destination = "/tmp/user-data.sh"   #cd tmp and then ls in ec2 machine to see this file

        connection {
        type        = "ssh"
        user        = "ubuntu"
        private_key = file("n.virginia-key.pem")
        host        = element(aws_instance.public-server.*.public_ip, count.index)
        #host = self.public_ip          #abhishek verramala explaination (agar instance k ander hi hain to ye b use ho skta hai)
        }
        }

        provisioner "remote-exec" {
        inline = [
        "sudo chmod 700 /tmp/userdata.sh",
        "sudo /tmp/userdata.sh",
        "sudo apt update",
        "sudo apt install jq unzip -y",
        ]

        connection {
        type        = "ssh"
        user        = "ubuntu"
        private_key = file("n.virginia-key.pem")
        host        = element(aws_instance.public-server.*.public_ip, count.index)
        }
        }
}

