#!/bin/bash

# Script to update Chrome for Testing and ChromeDriver

# Function to log messages
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Function to check if running as root
check_root() {
    if [ "$EUID" -ne 0 ]; then 
        log_message "Please run as root"
        exit 1
    fi
}

# Function to get the latest Chrome for Testing version
get_latest_chrome_version() {
    # Fetch the latest stable version from Chrome for Testing API
    LATEST_VERSION=$(curl -s https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions.json | grep -o '"Stable":{"channel":"Stable","version":"[^"]*' | grep -o '[^"]*$')
    
    if [ -z "$LATEST_VERSION" ]; then
        log_message "Failed to fetch latest Chrome version"
        exit 1
    fi
    
    echo "$LATEST_VERSION"
}

# Function to update Chrome for Testing
update_chrome() {
    log_message "Updating Chrome for Testing..."
    
    VERSION=$(get_latest_chrome_version)
    CHROME_URL="https://storage.googleapis.com/chrome-for-testing-public/$VERSION/linux64/chrome-linux64.zip"
    
    # Download Chrome
    wget -q "$CHROME_URL" -O /tmp/chrome-linux64.zip
    
    # Extract Chrome
    unzip -q /tmp/chrome-linux64.zip -d /tmp
    
    # Remove existing Chrome if it exists
    rm -f /usr/local/bin/google-chrome
    
    # Install new Chrome
    mv /tmp/chrome-linux64/chrome /usr/local/bin/google-chrome
    chmod +x /usr/local/bin/google-chrome
    
    # Clean up
    rm -rf /tmp/chrome-linux64 /tmp/chrome-linux64.zip
    
    log_message "Chrome for Testing updated successfully"
}

# Function to update ChromeDriver
update_chromedriver() {
    log_message "Updating ChromeDriver..."
    
    VERSION=$(get_latest_chrome_version)
    CHROMEDRIVER_URL="https://storage.googleapis.com/chrome-for-testing-public/$VERSION/linux64/chromedriver-linux64.zip"
    
    # Download ChromeDriver
    wget -q "$CHROMEDRIVER_URL" -O /tmp/chromedriver-linux64.zip
    
    # Extract ChromeDriver
    unzip -q /tmp/chromedriver-linux64.zip -d /tmp
    
    # Remove existing ChromeDriver if it exists
    rm -f /usr/local/bin/chromedriver
    
    # Install new ChromeDriver
    mv /tmp/chromedriver-linux64/chromedriver /usr/local/bin/chromedriver
    chmod +x /usr/local/bin/chromedriver
    
    # Clean up
    rm -rf /tmp/chromedriver-linux64 /tmp/chromedriver-linux64.zip
    
    log_message "ChromeDriver updated successfully"
}

# Function to verify installation
verify_installation() {
    log_message "Verifying installation..."
    
    if [ -f "/usr/local/bin/google-chrome" ]; then
        CHROME_VERSION=$(/usr/local/bin/google-chrome --version)
        log_message "Chrome version: $CHROME_VERSION"
    else
        log_message "Chrome installation failed"
        exit 1
    fi
    
    if [ -f "/usr/local/bin/chromedriver" ]; then
        CHROMEDRIVER_VERSION=$(/usr/local/bin/chromedriver --version)
        log_message "ChromeDriver version: $CHROMEDRIVER_VERSION"
    else
        log_message "ChromeDriver installation failed"
        exit 1
    fi
}

# Main execution
main() {
    log_message "Starting Chrome for Testing and ChromeDriver update process..."
    
    # Check if running as root
    check_root
    
    # Install required packages
    apt-get update && apt-get install -y wget unzip curl
    
    # Update Chrome
    update_chrome
    
    # Update ChromeDriver
    update_chromedriver
    
    # Verify installation
    verify_installation
    
    log_message "Update process completed successfully"
}

# Run main function
main
