# User data
data "template_file" "openvpn_server_data" {
  template = file("${path.module}/../../templates/user_data/openvpn_server/user_data.sh")
}

data "template_cloudinit_config" "openvpn_server_data" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.openvpn_server_data.rendered
  }
}

resource "aws_network_interface" "primary" {
  subnet_id            = var.subnet_id
  security_groups      = [aws_security_group.openvpn_server.id]
  source_dest_check    = false

  tags = merge(
      var.tags,
      {
          Name = "openvpn_server_primary_network_interface"
      }
  )
}

resource "aws_eip" "openvpn_server" {
  vpc                  = true
  network_interface    = aws_network_interface.primary.id

  depends_on = [
    aws_instance.openvpn_server
  ]
}

resource "aws_instance" "openvpn_server" {

  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.ssh_key_name
  monitoring                  = true

  network_interface {
    network_interface_id = aws_network_interface.primary.id
    device_index         = 0
  }

  user_data = data.template_cloudinit_config.openvpn_server_data.rendered

  tags = merge(
    var.tags,
    {
      Name = "OpenVPN Server"
    }
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [
      network_interface
    ]
  }
}