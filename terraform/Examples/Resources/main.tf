
resource "local_file" "pet" {
  filename = var.filename
  content  = "My favorite pet is Mr.Cat"

  depends_on = [
    random_pet.my-pet
  ]
}

resource "random_pet" "my-pet" {
  prefix    = var.prefix
  separator = var.seperator
  length    = var.length
}



output "my_filename" {
  value = local_file.pet.filename
}

output "my_content" {
  value = local_file.pet.content
}
