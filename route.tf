resource "aws_route_table" "public" {
  vpc_id = aws_vpc.db.id

  route {
    cidr_block = var.route_cidr
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = var.tags_public_route
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.db.id

  route {
    cidr_block = var.route_cidr
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = var.tags_private_route
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private.id
}

