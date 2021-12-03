##################### GLOBAL VARIABLES #####################
variable "environment" {
  default = "teste_glpi"
}

##################### EC2 VARIABLES #####################
variable "key_config" {
  default = {
    key_name = "glpi"
    key_path = "~/glpi.pem"
  }
}

variable "ssh_user" {
  default = "ubuntu"
}

variable "instance_type" {
  default = "t2.micro"
}
variable "ec2_tag" {
  default = "teste_glpi"
}

variable "volume_size" {
  default = 10
}
##################### EBS VARIABLES ##################### 
variable "ebs_device" {
  default = "/dev/xvdf"
}

variable "ebs_volume_size" {
  default = 10
}

variable "ebs_tag" {
  default = "teste_glpi"
}