#!/bin/env bash

set -euo pipefail
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo "Starting user data..."
# Install necessary libraries
apt-get update
apt-get upgrade -y

touch /opt/success
echo "All done"