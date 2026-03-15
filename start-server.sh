#!/bin/bash

echo "============================================================"
echo "Kids Music Player - Starting Development Server"
echo "============================================================"
echo ""

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null
then
    echo "ERROR: Python 3 is not installed"
    echo "Please install Python 3 first"
    echo ""
    echo "On Raspberry Pi/Debian/Ubuntu:"
    echo "  sudo apt install python3"
    echo ""
    echo "On macOS:"
    echo "  brew install python3"
    echo ""
    exit 1
fi

echo "Starting server..."
echo ""
echo "Once started, open your browser and go to:"
echo "  http://localhost:8000"
echo ""
echo "To access from other devices on your network:"
echo "  http://$(hostname -I | awk '{print $1}'):8000"
echo ""
echo "Press Ctrl+C to stop the server"
echo "============================================================"
echo ""

python3 server.py
