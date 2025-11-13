#!/usr/bin/env bash
set -e

URL=${1:-http://localhost:8080/health}
MAX_RETRIES=10
SLEEP_SECONDS=3

echo "Checking health of app at: $URL"

for i in $(seq 1 $MAX_RETRIES); do
  STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$URL" || echo "000")
  if [ "$STATUS" = "200" ]; then
    echo "Health OK (HTTP 200) on attempt $i ✅"
    exit 0
  fi
  echo "Attempt $i: status=$STATUS (expected 200). Retrying in ${SLEEP_SECONDS}s..."
  sleep "$SLEEP_SECONDS"
done

echo "Health check FAILED after $MAX_RETRIES attempts ❌"
exit 1
