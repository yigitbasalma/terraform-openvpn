module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  # Create VPC
  name                         = "${var.environment}-vpc"
  cidr                         = var.cidr_block
  azs                          = var.azs

  # Create Subnets
  public_subnets          = slice(var.subnets, 0, 7)
  private_subnets         = slice(var.subnets, 8, 16)

  # Subnet Tags for Kubernetes
  public_subnet_tags = {
    "kubernetes.io/role/elb"          = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  # Commons
  enable_nat_gateway      = true
  single_nat_gateway      = true
  enable_dns_hostnames    = true

  tags  = var.tags
}