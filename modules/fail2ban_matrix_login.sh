#!/usr/bin/env bash
# Fail2Ban jail for Matrix login brute-force
set -euo pipefail

cat > /etc/fail2ban/filter.d/matrix-login.conf << 'EOF'
[Definition]
failregex = ^<HOST> -.*"(POST).*(/_matrix/client/|/v3/login).*" .*
ignoreregex =
EOF

cat > /etc/fail2ban/jail.d/matrix-login.local << 'EOF'
[matrix-login]
enabled = true
filter = matrix-login
port = http,https
logpath = /var/log/nginx/access.log
maxretry = 6
findtime = 600
bantime = 3600
EOF

systemctl restart fail2ban
echo "[+] Fail2Ban matrix-login brute-force protection active."
