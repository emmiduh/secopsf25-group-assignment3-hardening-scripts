#!/usr/bin/env bash
# Block malicious attacker IPs identified during investigation
set -euo pipefail

# List of malicious IPs extracted from incident logs / IOC analysis
IPS=(
  172.29.108.82
  172.29.108.57
  172.29.106.110
  172.29.104.71
  172.29.105.25
  172.29.104.73
  172.29.106.179
)

# Iterate through each IP and add a UFW deny rule with a comment
for ip in "${IPS[@]}"; do
  ufw deny from "$ip" comment "IOC Block"
done

# Ensure UFW is enabled (force = avoid interactive prompt)
ufw --force enable

echo "[+] IOC-based IP blocking applied."

