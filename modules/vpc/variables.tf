variable "environment" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}

variable "azs" {
  type = list(string)
}