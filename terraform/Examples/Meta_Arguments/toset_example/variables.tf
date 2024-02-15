
variable "filename" {
  type = list(string)
  default = [
    "/tmp/pets.txt",
    "/tmp/dogs.txt",
    "/tmp/cats.txt"
  ]
}
