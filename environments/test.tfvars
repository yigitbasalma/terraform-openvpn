region                = "us-east-1"
ami_id                = "ami-0ec1545979d0dc885"
environment           = "test"
base_tags             = {
  "Created-by" = "iac-terraform"
}
permitted_ssh_ips     = [
  "192.168.2.0/24"
]

# VPC
vpc_cidr_block      = "172.30.0.0/16"

# OpenVPN
openvpn_enabled     = true
openvpn_ami_id      = "ami-037ff6453f0855c46"
openvpn_groups      = [
  {
    name    = "DevOps"
    subnet  = "192.168.2.0"
    prefix  = 24
  },
  {
    name    = "DBA"
    subnet  = "192.168.3.0"
    prefix  = 24
  }
]
openvpn_users       = [
  {
    username = "yigitcan.basalma",
    group    = "DevOps"
    ip       = "192.168.2.100"
    email    = "yigit.basalma@gmail.com"
  }
]