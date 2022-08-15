# Get all available zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Read public key if create_ssh_key parameter false
data "template_file" "public_key" {
  template = try(file("templates/ssh/${var.environment}/id_rsa.pub"), "templates/ssh/${var.environment}/id_rsa.pub path has to exists.")
}

# Read private key if create_ssh_key parameter false
data "template_file" "private_key" {
  template = try(file("templates/ssh/${var.environment}/id_rsa"), "templates/ssh/${var.environment}/id_rsa path has to exists.")
}

# Get source IP
data "http" "source_ip" {
  url = "https://ifconfig.io"
}

# Random password for everything
resource "random_password" "password" {
  length           = 16
  override_special = ".*-_"
}

# Random password for OpenVPN users
resource "random_password" "openvpn_password" {
  count            = length(var.openvpn_users)

  length           = 16
  override_special = ".*-_"
}

# Configure cidrs
module "subnet_addrs" {
  source = "hashicorp/subnets/cidr"

  base_cidr_block = var.vpc_cidr_block
  networks        = local.cidr_networks
}