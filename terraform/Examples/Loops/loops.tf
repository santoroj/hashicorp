resource "random_uuid" "test" {}

# resource "aws_s3_bucket" "mys3bucket" {
#     bucket = "mytestbucket-${random_uuid.test.result}"
# }


variable "users" {
  type    = list(any)
  default = ["joes", "diane", "grazia", "abigail", "amelia", "erin"]
}

resource "aws_iam_user" "myusers" {
  for_each = toset(var.users)
  name     = each.value
}

output "Joes_Linue" {
  value = "============================================================================"
}


locals {
  toppings = ["lettuce", "tomatoes", "onions", "jalapenos"]
}

resource "local_file" "for_each_loop" {
  for_each             = toset(local.toppings)
  directory_permission = "000"
  file_permission      = "000"
  content              = each.value
  filename             = "${path.module}/${each.value}.txt"
}

