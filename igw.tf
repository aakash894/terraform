resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.db.id
  tags   = var.tags_igw
}