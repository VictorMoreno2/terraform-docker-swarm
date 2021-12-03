output "teste_glpi_public_ip" {
  value = aws_eip.glpi_eip.public_ip
}

output "availability_zone_subnet" {
  value = data.aws_subnet.selected.availability_zone
}
