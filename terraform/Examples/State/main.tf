
resource "local_file" "pet" {
  filename = "/tmp/pet.txt"
  content  = "My favorite pet is Mr.Whiskers"
}

resource "random_pet" "my-pet" {
  length = var.length
}

resource "local_file" "cat" {
  filename = "/tmp/cat.txt"
  content  = "I like cats too!"
}

