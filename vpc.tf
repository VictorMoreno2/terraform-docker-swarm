resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}
data "aws_subnet_ids" "default" {
  vpc_id = aws_default_vpc.default.id
}

data "aws_subnet" "selected" {
  id = tolist(data.aws_subnet_ids.default.ids)[0]
}