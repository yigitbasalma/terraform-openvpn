resource "aws_security_group" "openvpn_server" {
  name_prefix = "OpenVPN Servers SG"
  description = "OpenVPN Server Security Rules"
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "OpenVPN Server"
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "openvpn_server_allow_https_inbound" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.openvpn_server.id
}

resource "aws_security_group_rule" "openvpn_server_allow_tcp_943_inbound" {
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.openvpn_server.id
}

resource "aws_security_group_rule" "openvpn_server_allow_udp_1194_inbound" {
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.openvpn_server.id
}

resource "aws_security_group_rule" "openvpn_server_allow_tcp_22_inbound" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_cidr_block]
  security_group_id = aws_security_group.openvpn_server.id
}

resource "aws_security_group_rule" "openvpn_server_allow_all_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.openvpn_server.id
}