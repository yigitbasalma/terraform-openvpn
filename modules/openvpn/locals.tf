locals {
  # Create route object for OpenVPN subnets
  openvpn_routes = flatten([
      for i in range(length(data.aws_route_tables.rts.ids)):
        [
          for e in range(length(var.groups)): {rt_id = tolist(data.aws_route_tables.rts.ids)[i], subnet = "${var.groups[e].subnet}/${var.groups[e].prefix}"}
        ]
  ])
}