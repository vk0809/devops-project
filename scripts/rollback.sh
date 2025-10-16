#!/bin/bash
set -e

echo "♻️ Starting rollback..."

# Find which color is currently stopped
if docker ps | grep -q "blue"; then
  STOPPED="green"
else
  STOPPED="blue"
fi

echo "🔁 Restarting previous version: $STOPPED"
docker start $STOPPED || echo "⚠️ No stopped container found."

echo "✅ Rollback complete."

