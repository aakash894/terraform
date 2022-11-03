output "vpc_id" {
  value = aws_vpc.db.id
}

output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "subnet_id_public_1" {
  value = aws_subnet.public1.id
}

output "subnet_id_public_2" {
  value = aws_subnet.public2.id
}

output "subnet_id_private_1" {
  value = aws_subnet.private1.id
}

output "subnet_id_private_2" {
  value = aws_subnet.private2.id
}

output "eip_id" {
  value = aws_eip.nat.id
}

output "nat_id" {
  value = aws_nat_gateway.nat.id
}

output "public_route_id" {
  value = aws_route_table.public.id
}

output "private_route_id" {
  value = aws_route_table.private.id
}

output "Intance_public_ip" {
  value = aws_instance.db_client.public_ip
}

output "Instance_ips" {
  value = "${formatlist("%v", aws_instance.db_node.*.private_ip)}"
}
