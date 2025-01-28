# ye hum aws sy fetch ker k ly aye
data "aws_vpc" "data-source" {
  id = "vpc-0b4c57c9958ccf0af"
}
#IG
resource "aws_internet_gateway" "data-source-IGW" {
  vpc_id = data.aws_vpc.data-source.id

  tags = {
    Name = "data-source-IGW"
  }
}
