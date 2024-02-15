

# Convert a list to a set with "toset"
resource "local_file" "pet" {
  filename = each.value
  content  = data.local_file.dog.content
  for_each = toset(var.filename)
}


data "local_file" "dog" {
  filename = "/tmp/dog.txt"
}

output "pets" {
    /* value =  nonsensitive(local_file.pet) */
    sensitive = true
    value = local_file.pet
}

# To get an output run the following command
#  terraform output -json  pets  | jq .
# ie 
/* {
  "/tmp/cats.txt": {
    "content": "I like Dogs!\n",
    "content_base64": null,
    "directory_permission": "0777",
    "file_permission": "0777",
    "filename": "/tmp/cats.txt",
    "id": "bb411fda78928b4bfe629e8c16829374088147ed",
    "sensitive_content": null,
    "source": null
  },
  "/tmp/dogs.txt": {
    "content": "I like Dogs!\n",
    "content_base64": null,
    "directory_permission": "0777",
    "file_permission": "0777",
    "filename": "/tmp/dogs.txt",
    "id": "bb411fda78928b4bfe629e8c16829374088147ed",
    "sensitive_content": null,
    "source": null
  },
  "/tmp/pets.txt": {
    "content": "I like Dogs!\n",
    "content_base64": null,
    "directory_permission": "0777",
    "file_permission": "0777",
    "filename": "/tmp/pets.txt",
    "id": "bb411fda78928b4bfe629e8c16829374088147ed",
    "sensitive_content": null,
    "source": null
  }
} */