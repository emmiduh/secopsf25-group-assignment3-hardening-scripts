#!/usr/bin/env bash
# Enforce SSH key-only authentication to prevent password brute-force attacks
set -euo pipefail

# SSH configuration file path
SSHD_CONF="/etc/ssh/sshd_config"

# Backup the config before modifying (timestamped backup)
cp "$SSHD_CONF" "${SSHD_CONF}.bak-$(date +%F-%T)"

# Disable password authentication completely
sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' "$SSHD_CONF"
sed -i 's/^PasswordAuthentication yes/PasswordAuthentication no/' "$SSHD_CONF"
grep -q "^PasswordAuthentication no" "$SSHD_CONF" || echo "PasswordAuthentication no" >> "$SSHD_CONF"

# Disable challenge-response login (2nd form of password-based login)
sed -i 's/^#ChallengeResponseAuthentication yes/ChallengeResponseAuthentication no/' "$SSHD_CONF"
sed -i 's/^ChallengeResponseAuthentication yes/ChallengeResponseAuthentication no/' "$SSHD_CONF"
grep -q "^ChallengeResponseAuthentication no" "$SSHD_CONF" || echo "ChallengeResponseAuthentication no" >> "$SSHD_CONF"

# Ensure public key authentication is explicitly enabled
grep -q "^PubkeyAuthentication yes" "$SSHD_CONF" || echo "PubkeyAuthentication yes" >> "$SSHD_CONF"

# Restart SSH service to apply changes
systemctl restart sshd

echo "[+] SSH key-only authentication enforced."

