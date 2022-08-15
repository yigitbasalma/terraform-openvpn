variable "ami_id" {
  type = string
}

variable "vpc_id" {
  type  = string
}

variable "subnet_id" {
  type = string
}

variable "instance_type" {
  type  = string
}

variable "ssh_key_name" {
  type = string
}

variable "permitted_ssh_ips" {
  type = list(string)
}

variable "tags" {
  type  = map(string)
}