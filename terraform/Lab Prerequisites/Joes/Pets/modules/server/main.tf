resource "aws_instance" "ubuntu" {
  ami                         = var.ami
  instance_type               = var.size
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_groups
  associate_public_ip_address = true

  tags = {
    "Name"        = "Server from Module"
    "Environment" = "Training"
  }
}


