resource "aws_security_group" "bastion_server" {
  name_prefix = "Bastion Servers SG"
  description = "Bastion Server Security Rules"
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "Bastion Server"
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "allow_ssh_restricted" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.permitted_ssh_ips
  security_group_id = aws_security_group.bastion_server.id
}

resource "aws_security_group_rule" "bastion_allow_all_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion_server.id
}