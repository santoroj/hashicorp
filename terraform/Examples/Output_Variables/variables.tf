variable "filename" {
  default     = "/tmp/pets1.txt"
  description = "the path of the local file"
}


variable "content" {
  default     = "I love pets !"
  description = "contents of the file"
}

variable "prefix" {
  default     = "Mrs"
  type        = string
  description = "the prefix to be set"
}

variable "seperator" {
  default     = "."
  description = "the seperator"
}

variable "length" {
  default     = "1"
  type        = number
  description = "the length"
}


