

# ONly works with a map or a set
resource "local_file" "pet" {
  filename = each.value
  content  = data.local_file.dog.content
  for_each = var.filename
}


data "local_file" "dog" {
  filename = "/tmp/dog.txt"
}
