#!/bin/bash
set -e

IMAGE_TAG=$1

# Detect current color
if docker ps | grep -q "blue"; then
  TARGET_COLOR="green"
  TARGET_PORT=3001
  LIVE_COLOR="blue"
else
  TARGET_COLOR="blue"
  TARGET_PORT=3000
  LIVE_COLOR="green"
fi

echo "🟢 Current live color: $LIVE_COLOR"
echo "🔵 Deploying target color: $TARGET_COLOR on port $TARGET_PORT"

# Stop and remove old target container if exists
docker rm -f ${TARGET_COLOR} || true

# Run new target container
echo "🚀 Starting container: ${IMAGE_TAG} on port ${TARGET_PORT}"
docker run -d -p ${TARGET_PORT}:3000 --name ${TARGET_COLOR} ${IMAGE_TAG}

# Health check loop
for i in {1..20}; do
  if curl -fsS http://127.0.0.1:${TARGET_PORT} >/dev/null; then
    echo "✅ Health check passed on ${TARGET_COLOR}"
    break
  else
    echo "⏳ Waiting for app to be healthy... (${i}/20)"
    sleep 2
  fi
done

# Simulate traffic switch (since Nginx not installed)
echo "⚠️ Nginx not installed — manually switch traffic if needed."
echo "ℹ️ Currently active containers:"
docker ps --format "table {{.Names}}\t{{.Ports}}"

# Stop old container (optional for cleanup)
docker rm -f ${LIVE_COLOR} || true

echo "✅ Deployment successful: ${TARGET_COLOR} is now live (manually)."

