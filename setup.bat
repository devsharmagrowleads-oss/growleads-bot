@echo off
echo.
echo === Growleads Setup ===
echo.

where node >nul 2>nul
if %errorlevel% neq 0 (
    echo ERROR: Node.js is not installed.
    echo Download it from https://nodejs.org and run this again.
    pause
    exit /b 1
)

echo [1/3] Installing dependencies...
call npm install
if %errorlevel% neq 0 (
    echo.
    echo ERROR: npm install failed.
    echo If you see errors about "node-gyp" or "build tools", run this first:
    echo   npm install -g windows-build-tools
    echo Then run setup.bat again.
    pause
    exit /b 1
)

echo [2/3] Installing Chromium browser...
call npx playwright install chromium

echo [3/3] Creating config file...
if not exist .env (
    copy .env.example .env >nul
    echo Created .env — OPEN IT AND SET YOUR NAME (USER_NAME=YourName)
) else (
    echo .env already exists, skipping.
)

echo.
echo === Setup complete! ===
echo.
echo Next steps:
echo   1. Open .env in Notepad and change USER_NAME to your name
echo   2. Run: npm run login    (login to LinkedIn)
echo   3. Run: npm run daemon   (start the bot)
echo   4. Run: npm run dashboard (optional — view stats at localhost:3000)
echo.
pause
