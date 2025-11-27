#!/usr/bin/env bash
# Enforce SSH key-only authentication
set -euo pipefail

SSHD_CONF="/etc/ssh/sshd_config"
cp "$SSHD_CONF" "${SSHD_CONF}.bak-$(date +%F-%T)"

sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' "$SSHD_CONF"
sed -i 's/^PasswordAuthentication yes/PasswordAuthentication no/' "$SSHD_CONF"
grep -q "^PasswordAuthentication no" "$SSHD_CONF" || echo "PasswordAuthentication no" >> "$SSHD_CONF"

sed -i 's/^#ChallengeResponseAuthentication yes/ChallengeResponseAuthentication no/' "$SSHD_CONF"
sed -i 's/^ChallengeResponseAuthentication yes/ChallengeResponseAuthentication no/' "$SSHD_CONF"
grep -q "^ChallengeResponseAuthentication no" "$SSHD_CONF" || echo "ChallengeResponseAuthentication no" >> "$SSHD_CONF"

grep -q "^PubkeyAuthentication yes" "$SSHD_CONF" || echo "PubkeyAuthentication yes" >> "$SSHD_CONF"

systemctl restart sshd
echo "[+] SSH key-only authentication enforced."
