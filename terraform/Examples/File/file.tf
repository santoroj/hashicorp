
resource "local_file" "my-pet" {
  filename        = "pet-name.txt"
  file_permission = "0700"
  content         = "My pet is called finnegan!!"

}
resource "random_pet" "other-pet" {
  length    = 1
  prefix    = "Mr"
  separator = "."

}


resource "random_string" "iac_random" {
  length    = 100
  min_upper = 5
}




output "filename" {
  value = local_file.my-pet.filename
}

output "content" {
  value = local_file.my-pet.content
}


output "mystring" {
  value = random_string.iac_random.result
}
