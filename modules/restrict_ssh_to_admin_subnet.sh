#!/usr/bin/env bash
# Restrict SSH access so only trusted admin subnet can connect
set -euo pipefail

# Admin subnet allowed to access SSH (adjust based on real infra)
ADMIN_SUBNET="172.29.0.0/20"

# Allow SSH only from the trusted subnet
ufw allow from "$ADMIN_SUBNET" to any port 22 comment "Allow SSH only from admin subnet"

# Deny all other SSH connections
ufw deny 22/tcp

# Enable firewall rules
ufw --force enable

echo "[+] SSH restricted to $ADMIN_SUBNET"

