#!/usr/bin/env bash
# Restrict SSH to trusted admin subnet only
set -euo pipefail

ADMIN_SUBNET="172.29.0.0/20"   # <-- change if needed

ufw allow from $ADMIN_SUBNET to any port 22 comment "Allow SSH only from admin subnet"
ufw deny 22/tcp
ufw --force enable

echo "[+] SSH restricted to $ADMIN_SUBNET"
