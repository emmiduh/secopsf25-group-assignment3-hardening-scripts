#!/usr/bin/env bash
# Block malicious attacker IPs identified during investigation
set -euo pipefail

IPS=(
  172.29.108.82
  172.29.108.57
  172.29.106.110
  172.29.104.71
  172.29.105.25
  172.29.104.73
  172.29.106.179
)

for ip in "${IPS[@]}"; do
  ufw deny from $ip comment "IOC Block"
done

ufw --force enable
echo "[+] IOC-based IP blocking applied."
