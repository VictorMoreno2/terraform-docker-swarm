

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Ubuntu
}


resource "aws_instance" "teste_glpi" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.teste_glpi.id]
  key_name               = var.key_config.key_name
  availability_zone      = data.aws_subnet.selected.availability_zone
  root_block_device {
    volume_size = var.volume_size
  }
  tags = {
    Name        = var.ec2_tag
    environment = var.environment
  }
}