#!/usr/bin/env bash
# Add rate limiting, disable directory listing, block .map files, add security headers
set -euo pipefail

cat > /etc/nginx/snippets/hardening.conf << 'EOF'
limit_req_zone $binary_remote_addr zone=req_limit_per_ip:10m rate=5r/s;

server {
    limit_req zone=req_limit_per_ip burst=10 nodelay;
}

location ~* \.map$ {
    deny all;
}

autoindex off;

add_header X-Frame-Options SAMEORIGIN;
add_header X-Content-Type-Options nosniff;
add_header X-XSS-Protection "1; mode=block";
EOF

echo "[!] IMPORTANT: Add this line inside your existing server {} block:"
echo "    include /etc/nginx/snippets/hardening.conf;"

nginx -t && systemctl reload nginx
echo "[+] NGINX hardening applied."
