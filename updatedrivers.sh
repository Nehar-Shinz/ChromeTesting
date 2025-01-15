#!/bin/bash

log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Get latest version
CHROME_VERSION=$(curl -s https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions.json | grep -o '"Stable":{"channel":"Stable","version":"[^"]*' | grep -o '[^"]*$')

if [ -z "$CHROME_VERSION" ]; then
    log_message "Failed to fetch Chrome version"
    exit 1
fi

log_message "Installing Chrome and ChromeDriver version: $CHROME_VERSION"

# Install required packages
apt-get update && apt-get install -y wget unzip curl

# Download and install Chrome
wget -q "https://storage.googleapis.com/chrome-for-testing-public/$CHROME_VERSION/linux64/chrome-linux64.zip"
unzip -q chrome-linux64.zip
rm -f /usr/local/bin/google-chrome
mv chrome-linux64/chrome /usr/local/bin/google-chrome
chmod +x /usr/local/bin/google-chrome
rm -rf chrome-linux64 chrome-linux64.zip

# Download and install ChromeDriver
wget -q "https://storage.googleapis.com/chrome-for-testing-public/$CHROME_VERSION/linux64/chromedriver-linux64.zip"
unzip -q chromedriver-linux64.zip
rm -f /usr/local/bin/chromedriver
mv chromedriver-linux64/chromedriver /usr/local/bin/chromedriver
chmod +x /usr/local/bin/chromedriver
rm -rf chromedriver-linux64 chromedriver-linux64.zip

# Verify installation
CHROME_VERSION_INSTALLED=$(/usr/local/bin/google-chrome --version)
CHROMEDRIVER_VERSION_INSTALLED=$(/usr/local/bin/chromedriver --version)

log_message "Chrome version: $CHROME_VERSION_INSTALLED"
log_message "ChromeDriver version: $CHROMEDRIVER_VERSION_INSTALLED"
log_message "Update completed successfully"
