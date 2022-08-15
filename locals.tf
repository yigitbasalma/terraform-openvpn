locals {
    # Tags for all resources
    tags = merge(
        var.base_tags,
        {
            Environment = var.environment
        }
    )

    # SSH public key
    public_key = data.template_file.public_key.rendered

    # SSH private key
    private_key = data.template_file.private_key.rendered

    # Configure networks
    cidr_networks = [
        for i in range(16) : {name: format("%02d", i), new_bits: 4}
    ]

    # Create passwords for OpenVPN users
    openvpn_users = [
        for i in range(length(var.openvpn_users)) : merge(var.openvpn_users[i], { password = random_password.openvpn_password[i].result })
    ]
}