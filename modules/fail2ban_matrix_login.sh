#!/usr/bin/env bash
# Fail2Ban jail for detecting and blocking brute-force login attempts on Matrix server
set -euo pipefail

# Create a custom Fail2Ban filter for Matrix login URLs
cat > /etc/fail2ban/filter.d/matrix-login.conf << 'EOF'
[Definition]
# Detect failed login POST requests to Matrix authentication endpoints
failregex = ^<HOST> -.*"(POST).*(/_matrix/client/|/v3/login).*" .*
ignoreregex =
EOF

# Create a jail configuration for the new filter
cat > /etc/fail2ban/jail.d/matrix-login.local << 'EOF'
[matrix-login]
enabled   = true
filter    = matrix-login
port      = http,https
logpath   = /var/log/nginx/access.log
maxretry  = 6       # Number of failed attempts allowed
findtime  = 600     # Time window to count failures (10 minutes)
bantime   = 3600    # 1-hour ban
EOF

# Restart Fail2Ban to load new rules
systemctl restart fail2ban

echo "[+] Fail2Ban matrix-login brute-force protection active."

