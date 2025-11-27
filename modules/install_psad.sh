#!/usr/bin/env bash
# Install psad to detect port scans
set -euo pipefail

apt-get update
apt-get install -y psad

psad --sig-update
systemctl enable --now psad

echo "[+] PSAD installed and running."
