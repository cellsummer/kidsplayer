#!/bin/bash

# Deployment script for Kids Music Player on Raspberry Pi
# This script will install and configure the web server and deploy the application

set -e  # Exit on error

echo "============================================================"
echo "Kids Music Player - Raspberry Pi Deployment Script"
echo "============================================================"
echo ""

# Check if running on Raspberry Pi or Linux
if [[ ! -f /etc/os-release ]]; then
    echo "Warning: This script is designed for Raspberry Pi/Linux systems"
    read -p "Continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
WEB_ROOT="/var/www/html"

echo "Script directory: $SCRIPT_DIR"
echo "Web root: $WEB_ROOT"
echo ""

# Ask for confirmation
read -p "This will deploy the application to $WEB_ROOT. Continue? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Deployment cancelled."
    exit 0
fi

echo ""
echo "Step 1: Updating system packages..."
sudo apt update

echo ""
echo "Step 2: Installing web server..."
# Check if nginx is already installed
if command -v nginx &> /dev/null; then
    echo "Nginx is already installed."
else
    echo "Installing Nginx..."
    sudo apt install -y nginx
fi

echo ""
echo "Step 3: Stopping web server..."
sudo systemctl stop nginx || true

echo ""
echo "Step 4: Backing up existing web content..."
if [ -d "$WEB_ROOT" ]; then
    BACKUP_DIR="$WEB_ROOT.backup.$(date +%Y%m%d_%H%M%S)"
    echo "Creating backup at: $BACKUP_DIR"
    sudo cp -r "$WEB_ROOT" "$BACKUP_DIR"
fi

echo ""
echo "Step 5: Clearing web root..."
sudo rm -rf "$WEB_ROOT"/*

echo ""
echo "Step 6: Copying application files..."
sudo cp -r "$SCRIPT_DIR"/* "$WEB_ROOT/"

# Don't copy deployment scripts and development files
sudo rm -f "$WEB_ROOT/deploy-to-pi.sh"
sudo rm -f "$WEB_ROOT/start-server.sh"
sudo rm -f "$WEB_ROOT/start-server.bat"
sudo rm -f "$WEB_ROOT/server.py"
sudo rm -f "$WEB_ROOT/.gitignore"
sudo rm -f "$WEB_ROOT/songs.json"

echo ""
echo "Step 7: Setting permissions..."
sudo chown -R www-data:www-data "$WEB_ROOT"
sudo chmod -R 755 "$WEB_ROOT"
sudo find "$WEB_ROOT" -type f -exec chmod 644 {} \;

echo ""
echo "Step 8: Starting and enabling web server..."
sudo systemctl start nginx
sudo systemctl enable nginx

echo ""
echo "Step 9: Checking server status..."
if sudo systemctl is-active --quiet nginx; then
    echo "✓ Nginx is running successfully!"
else
    echo "✗ Error: Nginx failed to start"
    echo "Check logs with: sudo journalctl -xeu nginx"
    exit 1
fi

echo ""
echo "============================================================"
echo "Deployment Complete!"
echo "============================================================"
echo ""
echo "Your Kids Music Player is now running!"
echo ""

# Get IP address
IP_ADDRESS=$(hostname -I | awk '{print $1}')

echo "Access the application at:"
echo "  http://$IP_ADDRESS"
echo "  http://$(hostname).local"
echo ""
echo "From this device:"
echo "  http://localhost"
echo ""

echo "Next steps:"
echo "  1. Add your MP3 files to: $WEB_ROOT/assets/songs/"
echo "  2. Add your thumbnail images to: $WEB_ROOT/assets/thumbnails/"
echo "  3. Edit the song list in: $WEB_ROOT/index.html"
echo ""

# Check if songs exist
if [ -z "$(ls -A $WEB_ROOT/assets/songs/*.mp3 2>/dev/null)" ]; then
    echo "⚠ WARNING: No MP3 files found in assets/songs/"
    echo "   Copy your songs with:"
    echo "   sudo cp /path/to/your/songs/*.mp3 $WEB_ROOT/assets/songs/"
    echo ""
fi

# Check if thumbnails exist
if [ -z "$(ls -A $WEB_ROOT/assets/thumbnails/*.{jpg,jpeg,png,gif} 2>/dev/null)" ]; then
    echo "⚠ WARNING: No thumbnail images found in assets/thumbnails/"
    echo "   Copy your images with:"
    echo "   sudo cp /path/to/your/images/*.jpg $WEB_ROOT/assets/thumbnails/"
    echo ""
fi

echo "To view logs: sudo journalctl -xeu nginx"
echo "To restart server: sudo systemctl restart nginx"
echo ""
echo "Enjoy! 🎵"
echo "============================================================"
