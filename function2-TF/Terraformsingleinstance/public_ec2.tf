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
    user_data = <<-EOF
    #!/bin/bash
    sudo apt update
    sudo apt install nginx -y
    sudo apt install git -y
    sudo git clone https://github.com/saikiranpi/SecOps-game.git
    sudo rm -rf /var/www/html/index.nginx-debian.html
    sudo cp  SecOps-game/index.html /var/www/html/index.html
    echo "<h1>${var.vpc_name}-private-Server-${count.index + 1}</h1>" >> /var/www/html/index.html
    sudo systemctl start nginx
    sudo systemctl enable nginx
    EOF
}