variable "filename1" {
  default     = "/tmp/pets1.txt"
  description = "the path of the local file"
}

variable "filename2" {
  default     = "/tmp/pets2.txt"
  description = "the path of the local file"
}

variable "content" {
  default     = "My Favorit pet is Mrs Whiskers"
  description = "contents of the file"
}

variable "prefix-title" {
  default     = ["Mr", "Mrs", "Sir"]
  type        = list(string)
  description = "the prefix to be set"
}

variable "prefix-numbers" {
  default     = ["1", "2", "3"]
  type        = list(number)
  description = "the prefix to be a number"
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

variable "password_change" {
  default = "true"
  type    = bool
}


variable "file-content" {
  type = map(any)
  default = {
    "statement1" = "We love pets!"
    "statement2" = "We love animals!"
  }
}



variable "cats" {
  default = {
    "color" = "brown"
    "name"  = "bella"
  }
  type = map(string)
}


#
# Map Example
#
variable "pet_count" {
  default = {
    "dogs"     = "3"
    "cats"     = "1"
    "goldfish" = "2"
  }
  type = map(number)
}


#
# Set Examples same as a list but cannot have duplicates
#
variable "fruit" {
  default = ["apple", "bannana"]
  type    = set(string)
}



variable "age" {
  default     = ["10", "12", "15", "40", "50"]
  type        = set(number)
  description = "The  Users age"
}




#
# Objects
#
variable "bella" {
  type = object({
    name         = string
    color        = string
    age          = number
    food         = list(string)
    favorite_pet = bool
  })
  default = {
    name         = "bella"
    color        = "brown"
    age          = 7
    food         = ["fish", "chicken", "turkey"]
    favorite_pet = true
  }
}


#
# Tuples
# 
variable "kitty" {
  type    = tuple([string, number, bool])
  default = ["cat", 7, true]
}























