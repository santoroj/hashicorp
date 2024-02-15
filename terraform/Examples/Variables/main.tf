
resource "local_file" "my-pet" {
  filename = var.filename1
  content  = var.content
}


resource "local_file" "my-pet2" {
  filename = var.filename2
  content  = var.file-content["statement2"]
}

resource "random_pet" "my-pet" {
  prefix    = var.prefix-title[0]
  separator = var.seperator
  length    = var.length
}


output "cat_name" {
  value = var.cats["name"]
}

output "cat_color" {
  value = var.cats["color"]
}

output "count_dogs" {
  value = var.pet_count["dogs"]
}

output "kitty_type" {
  value = var.kitty[0]
}

output "bella_food" {
  value = var.bella.food[0]
}
