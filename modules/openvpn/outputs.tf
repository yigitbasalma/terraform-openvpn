output "public_ip" {
  value = aws_eip.openvpn_server.public_ip
}

output "public_dns" {
  value = aws_eip.openvpn_server.public_dns
}

output "private_ip" {
  value = aws_instance.openvpn_server.private_ip
}