resource "aws_iam_role" "bastion" {
  name = "bastion_role"
  path = "/"

  inline_policy {
    name = "bastion_role_policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = [
            "ec2:ReplaceRouteTableAssociation",
            "ec2:DescribeTags",
            "ec2:CreateTags",
            "ec2:CreateRoute",
            "ec2:DisassociateRouteTable",
            "ec2:DescribeRouteTables",
            "ec2:AssociateRouteTable"
          ]
          Effect   = "Allow"
          Resource = ["*"]
        }
      ]
    })
  }

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_instance_profile" "bastion" {
  name = "bastion_profile"
  role = aws_iam_role.bastion.name
}