# Growleads Bot

LinkedIn engagement automation tool. It opens a real Chromium browser with a saved LinkedIn session, scrolls the feed during three configurable time windows a day, and reacts to posts that match your keywords. A local dashboard shows stats and lets you edit keywords and settings.

Built with Node.js, Playwright, Express and SQLite (better-sqlite3).

For the step-by-step guide written for team members, see [TEAM-SETUP.md](TEAM-SETUP.md).

## Requirements

- Node.js 20 or newer. Node.js 18 and 19 are not supported: the `better-sqlite3` dependency supports Node.js 20, 22, 23, 24 and 25 only. An `.nvmrc` is included, so `nvm use` selects Node.js 20.
- npm (ships with Node.js)
- Windows 10/11, macOS or Linux
- A LinkedIn account

## Install

```bash
git clone https://github.com/devsharmagrowleads-oss/growleads-bot.git
cd growleads-bot
npm install
npx playwright install chromium
```

`npx playwright install chromium` downloads the Chromium browser that the bot drives.

Then create your config file:

```bash
# macOS/Linux
cp .env.example .env

# Windows
copy .env.example .env
```

`npm run setup` runs the same three steps (install dependencies, install Chromium, create `.env`) in one command.

## Configure

Open `.env` and set at least:

| Variable | Description |
|---|---|
| `USER_NAME` | Your name, used to label your sessions |
| `TIMEZONE` | Your IANA timezone, e.g. `Europe/London` |
| `MORNING_WINDOW`, `AFTERNOON_WINDOW`, `EVENING_WINDOW` | When sessions run, as `HH:MM-HH:MM` |
| `ADMIN_API_URL`, `ADMIN_API_KEY` | Optional. Address and key of a central admin server that receives session reports. Leave `ADMIN_API_URL` empty to disable reporting |

The other values in `.env.example` (daily targets, jitter, session length, viewport) have working defaults. Keywords live in `config/keywords.json` and can also be edited from the dashboard.

## Run

1. Log in to LinkedIn once. A browser window opens; log in, and close it when you see your feed. The session is saved in `browser-profile/`.

   ```bash
   npm run login
   ```

2. Start the bot:

   ```bash
   npm run daemon
   ```

3. Optionally start the local dashboard and open http://localhost:3000:

   ```bash
   npm run dashboard
   ```

## Scripts

| Command | Description |
|---|---|
| `npm run setup` | Install dependencies and Chromium, create `.env` |
| `npm run login` | Open a browser to log in to LinkedIn |
| `npm start` | Run a single session now |
| `npm run daemon` | Keep running and start sessions during the configured windows |
| `npm run dashboard` | Start the local dashboard on port 3000 |

`start.bat` and `start.sh` start the dashboard. `scripts/setup-scheduler.bat` (Windows Task Scheduler) and `scripts/setup-cron.sh` (cron) schedule the daily sessions; the matching `remove-*` scripts undo that.

## Troubleshooting

If `npm install` fails while building `better-sqlite3`, check your Node.js version first (`node -v`). On a supported version a prebuilt binary is normally downloaded; otherwise it is compiled from source, which needs a C++ toolchain (Visual Studio Build Tools on Windows, `xcode-select --install` on macOS, `build-essential` and `python3` on Linux).

More fixes are listed in [TEAM-SETUP.md](TEAM-SETUP.md#troubleshooting).

## Local data

`browser-profile/` (LinkedIn session cookies), `data/` (SQLite database, logs) and `.env` are created locally and are ignored by git. Do not commit or share them.
