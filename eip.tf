resource "aws_eip" "glpi_eip" {
  vpc = true

  tags = {
    Name        = var.ec2_tag
    environment = var.environment
  }
}

resource "aws_eip_association" "glpi_eip_assoc" {
  instance_id   = aws_instance.teste_glpi.id
  allocation_id = aws_eip.glpi_eip.id
}

