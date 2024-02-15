
variable "filename" {
  type = set(string)
  default = [
    "/tmp/pets.txt",
    "/tmp/dogs.txt",
    "/tmp/cats.txt"
  ]
}
