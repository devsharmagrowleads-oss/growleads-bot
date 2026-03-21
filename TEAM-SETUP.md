# Growleads - Team Member Setup Guide

LinkedIn engagement automation tool. Follow these steps to get running on your machine.

---

## Requirements

- **Windows 10/11** (also works on macOS/Linux)
- **Node.js 18+** — Download from https://nodejs.org
- **A LinkedIn account** — logged in via Chrome

---

## Step 1: Get the files

Your admin will share a ZIP file with you. Extract it to any folder (e.g. `Desktop/growleads`).

---

## Step 2: Install dependencies

Open a terminal in the extracted folder and run:

```bash
npm install
npx playwright install chromium
```

---

## Step 3: Configure your settings

Copy the example config:

```bash
# Windows
copy .env.example .env

# macOS/Linux
cp .env.example .env
```

Open `.env` in any text editor and update:

```env
# REQUIRED: Your name (so admin can identify you)
USER_NAME=YourActualName

# REQUIRED: Your team name (ask your admin)
TEAM=default

# These connect your bot to the central dashboard — DO NOT change
ADMIN_API_URL=https://growleads-admin.onrender.com
ADMIN_API_KEY=growleads-secret-2026

# Timezone — set to your actual timezone
TIMEZONE=Asia/Kolkata

# Session windows — when the bot runs automatically
MORNING_WINDOW=08:00-10:00
AFTERNOON_WINDOW=12:00-14:00
EVENING_WINDOW=17:00-19:00
```

The rest of the defaults are fine. Don't change daily targets unless told to.

---

## Step 4: Login to LinkedIn

```bash
npm run login
```

This opens a browser window. Log in to your LinkedIn account normally. Once you see your feed, close the browser — the session is saved.

---

## Step 5: Start the bot

**Option A: Run once (manual)**
```bash
npm start
```

**Option B: Run as daemon (recommended — auto-triggers during your configured windows)**
```bash
npm run daemon
```

**Option C: Double-click** `start.bat` (Windows) or run `./start.sh` (macOS/Linux)

---

## Step 6: Local dashboard (optional)

To see your personal stats and manage keywords:

```bash
npm run dashboard
```

Then open http://localhost:3000 in your browser.

---

## Keyword Configuration

By default, the bot reacts to all posts (30% rate to look human). To target specific topics:

1. Open the dashboard → **Keywords** page
2. Turn off "React to All"
3. Add primary keywords (high-priority topics)
4. Add secondary keywords (lower priority)
5. Configure reaction mapping (which reactions for which keywords)
6. Click **Save**

---

## FAQ

**Q: Does my laptop need to stay on?**
A: Yes — the bot runs a real Chrome browser on your machine. It only activates during your configured time windows.

**Q: What if LinkedIn asks for a CAPTCHA?**
A: The bot auto-pauses for 24 hours to avoid ban escalation. You'll see this in the dashboard.

**Q: Can I change my session times?**
A: Yes — edit `.env` or use the dashboard Settings page.

**Q: How do I re-login if my session expires?**
A: Run `npm run login` again.

**Q: What does "skip day" mean in the logs?**
A: The bot randomly skips ~20% of days to look more human. This is normal.

---

## Troubleshooting

| Problem | Fix |
|---------|-----|
| `Session expired` | Run `npm run login` |
| `CAPTCHA detected` | Wait 24 hours (auto-cooldown) |
| `Another session is running` | Wait or delete `data/session.lock` |
| `Selectors outdated` | Update may be needed — contact admin |
| Browser doesn't open | Run `npx playwright install chromium` |

---

## Support

Contact your team admin for help.
