variable "region" {
  description = "Target region"
  type        = string
}

variable "ami_id" {
  description = "General ami-id"
}

variable "permitted_ssh_ips" {
  description = "Permitted SSH IPs"
  type        = list(string)
}

variable "environment" {
  description = "Project environment"
  type        = string
}

variable "base_tags" {
  description = "Default tags for all resources"
  type        = map(string)
}

# Bastion Server
variable "bastion_instance_type" {
  description = "Bastion server instance type"
  type        = string
  default     = "t2.small"
}

# Notification
variable "email_host" {
  type        = string
}

variable "email_port" {
  type        = string
  default     = "587"
}

variable "email_username" {
  type        = string
}

variable "email_password" {
  type        = string
}

variable "email_from" {
  type        = string
}

# VPC
variable "vpc_cidr_block" {
  description = "Cidr block for VPC"
  type        = string
}

# OpenVPN
variable "openvpn_enabled" {
  description = "Enable OpenVPN for VPN service"
  type        = bool
  default     = false
}

variable "openvpn_ami_id" {
  description = "OpenVPN server ami-id"
  type        = string
}

variable "openvpn_instance_type" {
  description = "OpenVPN instance type"
  type        = string
  default     = "t2.small"
}

variable "openvpn_groups" {
  description = "OpenVPN groups for access to the private side"
  type        = list(map(string))
  default     = []
}

variable "openvpn_users" {
  description = "OpenVPN users for access to the private side"
  type        = list(map(string))
  default     = []
}