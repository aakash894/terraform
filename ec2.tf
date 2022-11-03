resource "aws_instance" "db_client" {
  ami                         = var.ami
  instance_type               = var.instance_type
  associate_public_ip_address = true
  availability_zone           = var.AZ1
  subnet_id                   = aws_subnet.public1.id
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.for_db_client.id]
  tags                        = var.tags_ec2_pub
  user_data                   = file("script.sh")
}

resource "aws_instance" "db_node" {
  ami                    = var.ami
  instance_type          = var.instance_type
  availability_zone      = var.AZ1
  subnet_id              = aws_subnet.private1.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.for_db_nodes.id]
  count                  = var.node_count
  tags                   = var.tags_ec2_priv
}