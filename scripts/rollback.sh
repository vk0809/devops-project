#!/usr/bin/env bash
set -euo pipefail
BLUE_PORT=3000; GREEN_PORT=3001
CUR=$(grep -o '127.0.0.1:[0-9]\+' /etc/nginx/conf.d/app_upstream.conf | cut -d: -f2)
[[ "$CUR" == "$BLUE_PORT" ]] && T=$GREEN_PORT || T=$BLUE_PORT
echo "Rolling back to $T"
echo "set \$app_upstream \"http://127.0.0.1:$T\";" | sudo tee /etc/nginx/conf.d/app_upstream.conf
sudo nginx -t && sudo systemctl reload nginx
