resource "aws_ebs_volume" "glpi_ebs" {
  availability_zone = data.aws_subnet.selected.availability_zone
  size              = var.ebs_volume_size

  tags = {
    Name        = var.ebs_tag
    environment = var.environment
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name                    = var.ebs_device
  volume_id                      = aws_ebs_volume.glpi_ebs.id
  instance_id                    = aws_instance.teste_glpi.id
  stop_instance_before_detaching = true
}