#user data ec2 k ander hi ku define nahi kia jata alag file mein ku daal rehy hain? answer is jab hum userdata mein editing kerty hain to TF instance ko pehly terminate kerta hai phir change update kerta hai
#becoz hamein permissions nahi hoti user_data script ko change kernny ki without stopping instance
# but meri requirment ye hai k mein kuch b change keru userdata mein mera instance band nahi ho or backend py whatever modifications we require wo ho jaye ,,---> for this solution is : terraform provisiones (file+remote-exec) is used
resource "aws_instance" "public-server" {
    #count = "${length(var.public_cidr_block)}"              #ab manually numbers add nahi kerny hony due to length function jo b list mein ho ga wo ider aa jaye ga
    #count condition k through dy rahy hain if environment == prod then deploy 3 ec2 else deploy 1 ec2
    count = "${var.environment == "Prod" ? 3 : 1}"
    ami = "${lookup(var.amis, var.aws_region)}"               #lookup(map, key, default)
    #availability_zone = "us-east-1a"                   #automatically it is going to take one subnet from below argument(sibnet_id) islyie comment ker dia
    instance_type = "t2.micro"
    key_name = var.key_name
    #subnet_id = "${aws_subnet.public-subnet.id}"   #this takes only one subnet id of public subnet 
    subnet_id = "${element(aws_subnet.public-subnet.*.id, count.index+1)}"   
    vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
    associate_public_ip_address = true	
    tags = {
        Name = "${var.vpc_name}-Public-Server-${count.index+1}"
	    Owner = local.Owner
        costcenter = local.costcenter
        TeamDL = local.TeamDL
        environment = "${var.environment}"
    }
    #again ye below code connection * proviosioners ko  ec2 k ander rekheun gy to TF modifications kerny py ec2 ko pehly terminate kery ga isliye hum null.tf bnayen gy
    # connection {
    #         type        = "ssh"
    #         user        = "ubuntu"
    #         private_key = file("n.virginia-key.pem")
    #         host        = element(aws_instance.public-servers.*.public_ip, count.index)
    #         #host = self.public_ip          #abhishek verramala explaination (agar instance k ander hi hain to ye b use ho skta hai)
    #         }
    # #file provisioner to copy a file from local to the remote ec2 instance
    # provisioner "file" {
    #     source      = "user-data.sh"
    #     destination = "/tmp/user-data.sh"
    # }
        
 }