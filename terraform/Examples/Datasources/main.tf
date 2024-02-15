#
# Copy the content from the file /tmp/dog.txt to /tmp/pets.txt
#

resource "local_file" "pet" {
  filename = "/tmp/pets.txt"
  content  = data.local_file.dog.content
}

#resource "local_file" "dog" {
#  filename = "/tmp/pets.txt"
#  content  = "We love dogs!"
#}


data "local_file" "dog" {
  filename = "/tmp/dog.txt"
}

