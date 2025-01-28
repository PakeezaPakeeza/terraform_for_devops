#public route table
resource "aws_route_table" "public-route-table" {
    vpc_id = "${aws_vpc.default.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }
    tags = {
        Name = "${var.vpc_name}-Public-RT"
        Owner = local.Owner
        costcenter = local.costcenter
        TeamDL = local.TeamDL
        environment = "${var.environment}"
    }
}
#private route table
resource "aws_route_table" "private-route-table" {
    vpc_id = "${aws_vpc.default.id}"

    tags = {
        Name = "${var.vpc_name}-Private-RT"
        Owner = local.Owner
        costcenter = local.costcenter
        TeamDL = local.TeamDL
        environment = "${var.environment}"
    }
}
#public route table assosciation
resource "aws_route_table_association" "public-subnets" {
    #count = 3     
    count = "${length(var.private_cidr_block)}"                                                                   #based on subnet cidr range subnets and RT associations will be auto deployed
    subnet_id = "${element(aws_subnet.public-subnet.*.id, count.index)}"            #splat expression +  element(list, index)The element function selects a single element from a list based on the provided index
    route_table_id = "${aws_route_table.public-route-table.id}"
}
#private route table assosciation
resource "aws_route_table_association" "private-subnets" {
    #count = 3
    count = "${length(var.private_cidr_block)}"
    subnet_id = "${element(aws_subnet.private-subnet.*.id, count.index)}"            #splat expression +  element(list, index)The element function selects a single element from a list based on the provided index
    route_table_id = "${aws_route_table.private-route-table.id}"
}