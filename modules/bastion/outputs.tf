output "public_ip" {
  value = aws_eip.bastion_server.public_ip
}

output "private_ip" {
  value = aws_eip.bastion_server.private_ip
}

output "instance_id" {
  value = aws_instance.bastion_server.id
}