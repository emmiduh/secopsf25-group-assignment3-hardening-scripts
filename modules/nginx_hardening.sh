#!/usr/bin/env bash
# Add rate limiting, directory listing restrictions, security headers, and .map file blocking for NGINX
set -euo pipefail

# Create a hardening snippet to include in the active NGINX server block
cat > /etc/nginx/snippets/hardening.conf << 'EOF'
# Create a rate-limit zone for each IP (max 5 requests per second)
limit_req_zone $binary_remote_addr zone=req_limit_per_ip:10m rate=5r/s;

server {
    # Apply the rate limit with a burst threshold
    limit_req zone=req_limit_per_ip burst=10 nodelay;
}

# Block access to .map files (leaked source maps)
location ~* \.map$ {
    deny all;
}

# Disable directory listing
autoindex off;

# Security headers
add_header X-Frame-Options SAMEORIGIN;
add_header X-Content-Type-Options nosniff;
add_header X-XSS-Protection "1; mode=block";
EOF

# Instruction to the admin (not automatically applied)
echo "[!] IMPORTANT: Add the following line inside your existing server {} block:"
echo "    include /etc/nginx/snippets/hardening.conf;"

# Verify config and reload NGINX
nginx -t && systemctl reload nginx

echo "[+] NGINX hardening applied."

