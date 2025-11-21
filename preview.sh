#!/usr/bin/env bash
set -euo pipefail
PORT="${1:-8080}"
ROOT="$(dirname "$0")"
cd "$ROOT"

URL="http://localhost:${PORT}/index.html"

echo "\nStarte lokalen Preview-Server…"
echo "Öffne: ${URL}"
echo "(Beende mit STRG+C)"

if command -v xdg-open >/dev/null 2>&1; then
  xdg-open "$URL" >/dev/null 2>&1 || true
elif command -v open >/dev/null 2>&1; then
  open "$URL" >/dev/null 2>&1 || true
fi

python3 -m http.server "$PORT" --bind 127.0.0.1
