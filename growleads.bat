@echo off
title Growleads - LinkedIn Engagement Tool
color 0A
echo.
echo   ==============================
echo    Growleads - LinkedIn Bot
echo   ==============================
echo.

:: Check if Node.js is installed
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo   Node.js not found. Installing automatically...
    echo.

    :: Download Node.js installer
    echo   Downloading Node.js...
    powershell -Command "Invoke-WebRequest -Uri 'https://nodejs.org/dist/v20.18.3/node-v20.18.3-x64.msi' -OutFile '%TEMP%\node-install.msi'" 2>nul

    if not exist "%TEMP%\node-install.msi" (
        echo   ERROR: Could not download Node.js.
        echo   Please install manually from https://nodejs.org
        pause
        exit /b 1
    )

    echo   Installing Node.js (this may ask for admin permission)...
    msiexec /i "%TEMP%\node-install.msi" /qn
    del "%TEMP%\node-install.msi" >nul 2>nul

    :: Refresh PATH
    set "PATH=%ProgramFiles%\nodejs;%PATH%"

    where node >nul 2>nul
    if %errorlevel% neq 0 (
        echo   Node.js installed. Please CLOSE and REOPEN this file.
        pause
        exit /b 0
    )
    echo   Node.js installed successfully!
    echo.
)

:: Check if dependencies are installed
if not exist "node_modules" (
    echo   [1/3] Installing dependencies (first time only)...
    call npm install --no-fund --no-audit 2>nul
    echo.
)

:: Check if Chromium is installed
if not exist "%LOCALAPPDATA%\ms-playwright" (
    echo   [2/3] Installing browser (first time only)...
    call npx playwright install chromium 2>nul
    echo.
)

:: Create .env if missing
if not exist ".env" (
    echo   [3/3] Creating config...
    copy .env.example .env >nul

    :: Ask for name
    echo.
    set /p USERNAME="   Enter your name: "
    powershell -Command "(Get-Content .env) -replace 'USER_NAME=YourName', 'USER_NAME=%USERNAME%' | Set-Content .env"
    echo.

    :: Auto-launch login
    echo   Opening LinkedIn login...
    echo   Log in to your LinkedIn account in the browser window.
    echo   Close the browser once you see your feed.
    echo.
    call node src/login.js
    echo.
)

:: Start dashboard + daemon
echo   Starting Growleads...
echo.
echo   Dashboard: http://localhost:3000
echo   Bot is running in the background.
echo   Keep this window open. Press Ctrl+C to stop.
echo.
start /b node src/server/server.js
node src/index.js --daemon
