variable "filename" {
  default     = "/tmp/pets1.txt"
  description = "the path of the local file"
}


variable "content" {
  default     = "My Favorit pet is Mrs Whiskers"
  description = "contents of the file"
}

variable "prefix" {
  default     = "Mr"
  type        = string
  description = "the prefix to be set"
}

variable "seperator" {
  default     = "."
  description = "the seperator"
}

variable "length" {
  default     = "2"
  type        = number
  description = "the length"
}


