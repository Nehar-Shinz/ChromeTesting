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
CHROME_URL="https://storage.googleapis.com/chrome-for-testing-public/$CHROME_VERSION/linux64/chrome-linux64.zip"
log_message "Downloading Chrome from: $CHROME_URL"
wget -q "$CHROME_URL"
if [ $? -ne 0 ]; then
    log_message "Failed to download Chrome"
    exit 1
fi

unzip -q chrome-linux64.zip
rm -f /usr/local/bin/google-chrome
mv chrome-linux64/chrome /usr/local/bin/google-chrome
chmod +x /usr/local/bin/google-chrome
rm -rf chrome-linux64 chrome-linux64.zip

# Download and install ChromeDriver
CHROMEDRIVER_URL="https://storage.googleapis.com/chrome-for-testing-public/$CHROME_VERSION/linux64/chromedriver-linux64.zip"
log_message "Downloading ChromeDriver from: $CHROMEDRIVER_URL"
wget -q "$CHROMEDRIVER_URL"
if [ $? -ne 0 ]; then
    log_message "Failed to download ChromeDriver"
    exit 1
fi

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

# Check if versions match
CHROME_NUMBER=$(echo "$CHROME_VERSION_INSTALLED" | grep -o '[0-9.]*' | head -1)
DRIVER_NUMBER=$(echo "$CHROMEDRIVER_VERSION_INSTALLED" | grep -o '[0-9.]*' | head -1)

if [ "$CHROME_NUMBER" != "$DRIVER_NUMBER" ]; then
    log_message "WARNING: Version mismatch detected!"
    log_message "Chrome: $CHROME_NUMBER"
    log_message "ChromeDriver: $DRIVER_NUMBER"
    exit 1
else
    log_message "Version match confirmed: $CHROME_NUMBER"
    log_message "Update completed successfully"
fi
