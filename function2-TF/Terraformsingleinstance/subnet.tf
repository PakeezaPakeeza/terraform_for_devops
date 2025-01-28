#3 public subnet
resource "aws_subnet" "public-subnet" {
    #count = 3   #ye kam length function sy b ho skta tha: count = length(var.public_cidr_block)   ku k variable mein list hai
                             #                            cidr_block  = var.public_cidr_block[count.index]
                             #lekin hum simple count use keren gy
    count = "${length(var.public_cidr_block)}"
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${element(var.public_cidr_block, count.index)}"       #element(list, index)
    availability_zone = "${element(var.azs, count.index)}"

    tags = {
        Name = "${var.vpc_name}-public-subnet-${count.index+1}"   #count.index hamein no wise name dy ga
	    Owner = local.Owner        #local static value
        costcenter = local.costcenter
        TeamDL = local.TeamDL
        environment = "${var.environment}"
    }
}
#3 private subnet
resource "aws_subnet" "private-subnet" {
    #count = 3
    count = "${length(var.private_cidr_block)}"         #ab manually numbers add nahi kerny hony due to length function jo b list mein ho ga wo ider aa jaye ga
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${element(var.private_cidr_block, count.index)}"       #element(list, index) retrieves single item form list based on index
    availability_zone = "${element(var.azs, count.index)}"

    tags = {
        Name = "${var.vpc_name}-private-subnet-${count.index+1}"
	    Owner = local.Owner
        costcenter = local.costcenter
        TeamDL = local.TeamDL
        environment = "${var.environment}"
    }
}