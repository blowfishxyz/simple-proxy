#!/bin/sh

# Replace placeholders with environment variables
sed -i 's|BLOWFISH_API_KEY_PLACEHOLDER|'${BLOWFISH_API_KEY}'|' /etc/nginx/nginx.conf

# Start Nginx
nginx -g "daemon off;"
