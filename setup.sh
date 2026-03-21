#!/bin/bash
set -e

echo ""
echo "=== Growleads Setup ==="
echo ""

if ! command -v node &>/dev/null; then
    echo "ERROR: Node.js is not installed."
    echo "Install it from https://nodejs.org and run this again."
    exit 1
fi

echo "[1/3] Installing dependencies..."
npm install

echo "[2/3] Installing Chromium browser..."
npx playwright install chromium

echo "[3/3] Creating config file..."
if [ ! -f .env ]; then
    cp .env.example .env
    echo "Created .env — OPEN IT AND SET YOUR NAME (USER_NAME=YourName)"
else
    echo ".env already exists, skipping."
fi

echo ""
echo "=== Setup complete! ==="
echo ""
echo "Next steps:"
echo "  1. Open .env and change USER_NAME to your name"
echo "  2. Run: npm run login    (login to LinkedIn)"
echo "  3. Run: npm run daemon   (start the bot)"
echo "  4. Run: npm run dashboard (optional — view stats at localhost:3000)"
echo ""
