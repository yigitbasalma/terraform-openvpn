# User data
data "template_file" "bastion_user_data" {
  template = file("${path.module}/../../templates/user_data/bastion_server/user_data.sh")
}

data "template_cloudinit_config" "bastion_user_data" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.bastion_user_data.rendered
  }
}

resource "aws_network_interface" "bastion_server" {
  subnet_id            = var.subnet_id
  security_groups      = [aws_security_group.bastion_server.id]

  tags = merge(
      var.tags,
      {
          Name = "bastion_primary_network_interface"
      }
  )
}

resource "aws_eip" "bastion_server" {
  vpc                 = true
  network_interface   = aws_network_interface.bastion_server.id

  depends_on = [
    aws_instance.bastion_server
  ]
}

resource "aws_instance" "bastion_server" {

  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.ssh_key_name
  monitoring                  = true
  iam_instance_profile        = aws_iam_instance_profile.bastion.name

  network_interface {
    network_interface_id = aws_network_interface.bastion_server.id
    device_index         = 0
  }

  user_data = data.template_cloudinit_config.bastion_user_data.rendered

  tags = merge(
    var.tags,
    {
      "Name" = "Bastion Server"
    }
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [
      network_interface
    ]
  }
}