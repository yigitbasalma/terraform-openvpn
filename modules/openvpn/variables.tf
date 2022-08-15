variable "region" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "vpc_id" {
  type  = string
}

variable "vpc_cidr_block" {
  type  = string
}

variable "subnet_id" {
  type  = string
}

variable "instance_type" {
  type  = string
}

variable "ssh_key_name" {
  type = string
}

variable "whitelisted_ips" {
  type = list(string)
}

variable "password" {
  type = string
}

variable "users" {
  type = list(map(string))
}

variable "groups" {
  type = list(map(string))
}

variable "email_host" {
  type        = string
  default     = ""
}

variable "email_port" {
  type        = string
  default     = ""
}

variable "email_username" {
  type        = string
  default     = ""
}

variable "email_password" {
  type        = string
  default     = ""
}

variable "email_from" {
  type        = string
  default     = ""
}

variable "environment" {
  type        = string
} 

variable "tags" {
  type  = map(string)
}

variable "bastion_ssh_private_key" {
  type = string
}

variable "bastion_public_ip" {
  type = string
}