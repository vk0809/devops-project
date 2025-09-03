#!/usr/bin/env bash
set -euo pipefail
APP_NAME="demo-app"
BLUE_PORT=3000
GREEN_PORT=3001

CURRENT_UPSTREAM=$(grep -o '127.0.0.1:[0-9]\+' /etc/nginx/conf.d/app_upstream.conf | cut -d: -f2 || true)
if [[ "$CURRENT_UPSTREAM" == "$BLUE_PORT" ]]; then
  TARGET_COLOR="green"; TARGET_PORT=$GREEN_PORT
else
  TARGET_COLOR="blue"; TARGET_PORT=$BLUE_PORT
fi

echo "Current live: ${CURRENT_UPSTREAM:-none}; target: $TARGET_COLOR($TARGET_PORT)"

EXISTING_ID=$(docker ps --filter "publish=$TARGET_PORT" --format '{{.ID}}' || true)
[[ -n "$EXISTING_ID" ]] && docker rm -f "$EXISTING_ID" || true

IMAGE="${1:?Image tag required}"
docker run -d --name "app-$TARGET_COLOR" -p ${TARGET_PORT}:3000 "$IMAGE"

for i in {1..20}; do
  if curl -fsS "http://127.0.0.1:$TARGET_PORT" >/dev/null; then HEALTHY=1; break; fi
  sleep 2
done
[[ "${HEALTHY:-0}" -eq 1 ]] || { echo "health failed"; exit 1; }

echo "set \$app_upstream \"http://127.0.0.1:$TARGET_PORT\";" | sudo tee /etc/nginx/conf.d/app_upstream.conf
sudo nginx -t && sudo systemctl reload nginx
echo "Switched traffic to $TARGET_COLOR ($TARGET_PORT)"
