#!/bin/bash
clear
echo ""
echo "  =============================="
echo "   Growleads - LinkedIn Bot"
echo "  =============================="
echo ""

# Check if Node.js is installed
if ! command -v node &>/dev/null; then
    echo "  Node.js not found. Installing automatically..."
    echo ""

    # Try Homebrew first
    if command -v brew &>/dev/null; then
        brew install node
    else
        # Install Homebrew, then Node
        echo "  Installing Homebrew first..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$(/opt/homebrew/bin/brew shellenv)" 2>/dev/null
        eval "$(/usr/local/bin/brew shellenv)" 2>/dev/null
        brew install node
    fi

    if ! command -v node &>/dev/null; then
        echo "  ERROR: Could not install Node.js."
        echo "  Please install manually from https://nodejs.org"
        exit 1
    fi
    echo "  Node.js installed!"
    echo ""
fi

# Install dependencies if missing
if [ ! -d "node_modules" ]; then
    echo "  [1/3] Installing dependencies (first time only)..."
    npm install --no-fund --no-audit 2>/dev/null
    echo ""
fi

# Install Chromium if missing
if [ ! -d "$HOME/Library/Caches/ms-playwright" ] && [ ! -d "$HOME/.cache/ms-playwright" ]; then
    echo "  [2/3] Installing browser (first time only)..."
    npx playwright install chromium 2>/dev/null
    echo ""
fi

# Create .env if missing
if [ ! -f ".env" ]; then
    echo "  [3/3] Creating config..."
    cp .env.example .env

    echo ""
    read -rp "   Enter your name: " USERNAME
    sed -i.bak "s/USER_NAME=YourName/USER_NAME=$USERNAME/" .env
    rm -f .env.bak

    echo ""
    echo "  Opening LinkedIn login..."
    echo "  Log in to your LinkedIn account in the browser window."
    echo "  Close the browser once you see your feed."
    echo ""
    node src/login.js
    echo ""
fi

# Start dashboard + daemon
echo "  Starting Growleads..."
echo ""
echo "  Dashboard: http://localhost:3000"
echo "  Bot is running in the background."
echo "  Keep this window open. Press Ctrl+C to stop."
echo ""
node src/server/server.js &
node src/index.js --daemon
