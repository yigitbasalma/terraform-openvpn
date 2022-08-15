resource "null_resource" "copy_resources" {
  provisioner "file" {
    source      = "${path.module}/../../ansible/openvpn"
    destination = "/tmp"

    connection {
        type        = "ssh"
        user        = "rocky"
        private_key = var.bastion_ssh_private_key
        host        = var.bastion_public_ip
        timeout     = "15m"
    }
  }
}

resource "null_resource" "run_ansible" {
  provisioner "remote-exec" {
    inline = [
        "echo '${var.bastion_ssh_private_key}' > /tmp/k",
        "echo ${aws_instance.openvpn_server.private_ip} >> /tmp/openvpn/inventories/hosts",
        "chmod 600 /tmp/k",
        "until [ -f /home/rocky/success ]; do sleep 5; done",
        "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i /tmp/openvpn/inventories/hosts --private-key /tmp/k -e ansible_user='openvpnas' -e ansible_remote_tmp='/tmp/.ansible/tmp' -e REGION='${var.region}' -e OVPN_ADMIN_PASSWORD='${nonsensitive(var.password)}' -e OVPN_URL='${aws_eip.openvpn_server.public_dns}' -e ENVIRONMENT='${var.environment}' -e USERS='${nonsensitive(jsonencode(var.users))}' -e GROUPS='${jsonencode(var.groups)}' -e EMAIL_HOST='${var.email_host}' -e EMAIL_PORT='${var.email_port}' -e EMAIL_USERNAME='${var.email_username}' -e EMAIL_PASSWORD='${var.email_password}' -e EMAIL_FROM='${var.email_from}' -e RT_ENTRIES='${jsonencode(local.openvpn_routes)}' -e INTERFACE_ID='${aws_network_interface.primary.id}' /tmp/openvpn/playbooks/sync-users.yaml"
    ]

    connection {
        type        = "ssh"
        user        = "rocky"
        private_key = var.bastion_ssh_private_key
        host        = var.bastion_public_ip
    }
  }

  depends_on = [
    null_resource.copy_resources
  ]
}