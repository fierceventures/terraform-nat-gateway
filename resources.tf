# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${var.vpc_id}"
  tags {
    name = "${var.env}-${var.name}"
  }
}

# Route to the Internet
resource "aws_route" "internet_access" {
  route_table_id = "${var.vpc_main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.gw.id}"
}

# Elastic IP
resource "aws_eip" "ip" {
  vpc = true
  depends_on = ["aws_internet_gateway.gw"]
}

# NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.ip.id}"
  subnet_id = "${var.public_subnet_id}"
  depends_on = ["aws_internet_gateway.gw"]
  tags {
    name = "${var.env}-${var.name}"
  }
}

resource "aws_route" "private_route" {
  route_table_id = "${var.private_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${aws_nat_gateway.nat.id}"
}
