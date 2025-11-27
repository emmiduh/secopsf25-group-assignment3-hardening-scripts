#!/usr/bin/env bash
# Install PSAD (Port Scan Attack Detection) to detect reconnaissance behavior
set -euo pipefail

# Update package lists and install psad
apt-get update
apt-get install -y psad

# Update PSAD signatures to latest threat intel
psad --sig-update

# Enable and start the PSAD service
systemctl enable --now psad

echo "[+] PSAD installed and running."

