#!/bin/env bash

set -euo pipefail
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo "Starting user data..."
# Install necessary libraries
dnf install epel-release -y
dnf install git awscli nc wget -y

# Disable selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
setenforce 0

# Install ansible
pip3 install ansible

# Create python symlink
ln -s /usr/bin/python3 /usr/bin/python

# Ansible config
mkdir -p /etc/ansible
wget https://raw.githubusercontent.com/ansible/ansible/stable-2.9/examples/ansible.cfg -O /etc/ansible/ansible.cfg

# Custom lib add
mkdir -p /home/rocky/.ansible/plugins
chown -R rocky. /home/rocky
ln -s /tmp/auto-devops/plugins/modules /home/rocky/.ansible/plugins/modules 2> /dev/null || true

# Helm binary install
wget https://get.helm.sh/helm-v3.8.1-linux-amd64.tar.gz -O /tmp/helm.tar.gz
tar -xzf /tmp/helm.tar.gz -C /tmp
chmod +x /tmp/linux-amd64/helm
mv /tmp/linux-amd64/helm /usr/bin

# Install AWS Authenticator binary
wget https://s3.us-west-2.amazonaws.com/amazon-eks/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator -O /tmp/aws-iam-authenticator
chmod +x /tmp/aws-iam-authenticator
mv /tmp/aws-iam-authenticator /usr/bin

touch /home/rocky/success
echo "All done"