module "vpc" {
  source    = "./modules/vpc"

  # Variables
  environment     = var.environment
  cidr_block      = var.vpc_cidr_block
  subnets         = module.subnet_addrs.networks[*].cidr_block
  tags            = merge(
    local.tags,
    {
      Module = "vpc"
    }
  )
  azs             = data.aws_availability_zones.available.names
}

module "bastion" {
  source = "./modules/bastion"

  # Variables
  ami_id              = var.ami_id
  vpc_id              = module.vpc.vpc_id
  subnet_id           = element(module.vpc.public_subnets, 0)
  instance_type       = var.bastion_instance_type
  ssh_key_name        = aws_key_pair.ssh_key.key_name
  permitted_ssh_ips   = distinct(concat(var.permitted_ssh_ips, ["${trim(data.http.source_ip.body, "\n")}/32"]))
  tags                = merge(
    local.tags,
    {
      Module = "bastion"
    }
  )
}

module "openvpn" {
  count     = var.openvpn_enabled ? 1 : 0  
  source    = "./modules/openvpn"

  # Variables
  region                  = var.region
  ami_id                  = var.openvpn_ami_id
  vpc_id                  = module.vpc.vpc_id
  vpc_cidr_block          = var.vpc_cidr_block
  subnet_id               = element(module.vpc.public_subnets, 2)
  instance_type           = var.openvpn_instance_type
  ssh_key_name            = aws_key_pair.ssh_key.key_name
  whitelisted_ips         = distinct(concat(var.permitted_ssh_ips, ["${trim(data.http.source_ip.body, "\n")}/32"]))
  password                = random_password.password.result
  groups                  = var.openvpn_groups
  users                   = local.openvpn_users
  email_host              = var.email_host
  email_port              = var.email_port
  email_username          = var.email_username
  email_password          = var.email_password
  email_from              = var.email_from
  environment             = var.environment
  tags                    = merge(
    local.tags,
    {
      Module = "openvpn"
    }
  )
  bastion_ssh_private_key = local.private_key
  bastion_public_ip       = module.bastion.public_ip

  # Dependency
  depends_on = [
    module.vpc,
    module.bastion.public_ip
  ]
}