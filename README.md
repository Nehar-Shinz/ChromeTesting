# Chrome & ChromeDriver Auto-Updater

A simple, automated solution for keeping Chrome for Testing and ChromeDriver in sync across multiple server instances. This script automatically fetches and installs the latest stable versions, ensuring compatibility between Chrome and ChromeDriver.

## 🚀 Features

- Automatically fetches the latest stable Chrome for Testing version
- Downloads and installs Chrome for Testing
- Downloads and installs matching ChromeDriver
- Performs automatic cleanup
- Includes version verification
- No manual version management needed
- Works across different Linux distributions

## 📋 Prerequisites

The script requires the following packages:
- curl
- wget
- unzip
- sudo privileges

These will be automatically installed if missing.

## 💻 Usage

### Quick Install (One-Line Command)
```bash
curl -s https://raw.githubusercontent.com/Nehar-Shinz/ChromeTesting/main/updatedrivers.sh | sudo bash
```

### Manual Installation
```bash
# Download the script
wget https://raw.githubusercontent.com/Nehar-Shinz/ChromeTesting/main/updatedrivers.sh

# Make it executable
chmod +x updatedrivers.sh

# Run the script
sudo ./updatedrivers.sh
```

## 🔧 What the Script Does

1. **Version Detection**
   - Fetches the latest stable version from Chrome for Testing API
   - Ensures Chrome and ChromeDriver versions match

2. **Chrome Installation**
   - Downloads Chrome for Testing
   - Installs in `/usr/local/bin/google-chrome`
   - Sets appropriate permissions

3. **ChromeDriver Installation**
   - Downloads matching ChromeDriver version
   - Installs in `/usr/local/bin/chromedriver`
   - Sets appropriate permissions

4. **Verification**
   - Verifies successful installation
   - Displays installed versions
   - Checks binary permissions

## 📝 Output Example

```bash
[2025-01-15 10:30:15] Starting Chrome for Testing and ChromeDriver update process...
[2025-01-15 10:30:16] Updating Chrome for Testing...
[2025-01-15 10:30:45] Chrome for Testing updated successfully
[2025-01-15 10:30:46] Updating ChromeDriver...
[2025-01-15 10:31:00] ChromeDriver updated successfully
[2025-01-15 10:31:01] Verifying installation...
[2025-01-15 10:31:02] Chrome version: 132.0.6834.83
[2025-01-15 10:31:02] ChromeDriver version: ChromeDriver 132.0.6834.83
[2025-01-15 10:31:02] Update process completed successfully
```

## ⚠️ Important Notes

- The script requires sudo privileges to install Chrome and ChromeDriver
- Previous versions will be automatically removed during installation
- The script performs automatic cleanup of temporary files
- Installation paths are fixed to ensure consistency:
  - Chrome: `/usr/local/bin/google-chrome`
  - ChromeDriver: `/usr/local/bin/chromedriver`

## 🔄 Automation Tips

You can automate this update process by:
- Adding it to your CI/CD pipeline
- Creating a cron job
- Including it in your server initialization scripts

Example cron job (weekly updates):
```bash
0 0 * * 0 curl -s https://raw.githubusercontent.com/Nehar-Shinz/ChromeTesting/main/updatedrivers.sh | sudo bash
```

## 🐛 Troubleshooting

If you encounter any issues:
1. Ensure you have sudo privileges
2. Check internet connectivity
3. Verify required packages are installed
4. Check system logs for any error messages

## 📄 License

MIT License - feel free to use and modify as needed!

## 👥 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
