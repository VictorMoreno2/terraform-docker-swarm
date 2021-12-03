resource "null_resource" "ansible_playbook" {
  triggers = {
    public_ip = aws_eip.glpi_eip.public_ip
  }
  provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'"]

    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file(var.key_config.key_path)
      host        = aws_eip.glpi_eip.public_ip
    }
  }
  provisioner "local-exec" {
    command = "ansible-playbook -i ${aws_eip.glpi_eip.public_ip}, --private-key ${var.key_config.key_path} site.yaml"
  }
}