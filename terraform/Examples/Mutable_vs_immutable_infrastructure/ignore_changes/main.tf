resource "aws_instance" "webserver" {
  ami           = "ami-078a289ddf4b09ae0"
  instance_type = "t2.nano"
  tags = {
    Name = "ProjectA-Webserver"
  }
  lifecycle {
    ignore_changes = [
      tags, ami
    ]
  }
}


# Can also use
# lifecycle {
#   ignore_changes = all 
# }
