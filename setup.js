const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

function run(cmd, label) {
  console.log(`\n[${label}]`);
  try {
    execSync(cmd, { stdio: 'inherit', cwd: __dirname });
  } catch {
    console.error(`\nFailed: ${cmd}`);
    console.error('If you see errors about "node-gyp" or "build tools":');
    console.error('  Windows: npm install -g windows-build-tools');
    console.error('  Mac: xcode-select --install');
    process.exit(1);
  }
}

console.log('\n=== Growleads Setup ===\n');

run('npm install', '1/3 Installing dependencies');
run('npx playwright install chromium', '2/3 Installing Chromium browser');

const envPath = path.join(__dirname, '.env');
if (!fs.existsSync(envPath)) {
  fs.copyFileSync(path.join(__dirname, '.env.example'), envPath);
  console.log('\n[3/3] Created .env file');
} else {
  console.log('\n[3/3] .env already exists, skipping');
}

console.log('\n=== Setup complete! ===\n');
console.log('Next steps:');
console.log('  1. Open .env and change USER_NAME to your name');
console.log('  2. Run: npm run login');
console.log('  3. Run: npm run daemon');
console.log('  4. Run: npm run dashboard  (optional — stats at localhost:3000)\n');
