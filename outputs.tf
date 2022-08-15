output "ssh_private_key" {
  value = "SSH key located in templates/${var.environment}/ssh"
}

output "openvpn_public_dns" {
  value = var.openvpn_enabled ? module.openvpn[0].public_dns : "OpenVPN should be enabled."
}

output "password_for_resources" {
  value = nonsensitive(random_password.password.result)
}