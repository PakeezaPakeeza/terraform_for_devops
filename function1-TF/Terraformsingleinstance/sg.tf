#ingress bar bar repeat na kenr a pery isliye dynamic blocking (for each)
resource "aws_security_group" "allow_all" {
  name        = "${var.vpc_name}-allow-all-SG"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.default.id}"

dynamic "ingress" {
  for_each = var.service_ports        #for_each inside dynamic can work also with list
  content{
    from_port   = ingress.value
    to_port     = ingress.value
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    }
    tags = {
        Name = "${var.vpc_name}-sg"
        
    }
#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

}

