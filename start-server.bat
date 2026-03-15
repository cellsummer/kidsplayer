@echo off
echo ============================================================
echo Kids Music Player - Starting Development Server
echo ============================================================
echo.

REM Check if Python is installed
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Python is not installed or not in PATH
    echo Please install Python from https://www.python.org/
    echo.
    pause
    exit /b 1
)

echo Starting server...
echo.
echo Once started, open your browser and go to:
echo http://localhost:8000
echo.
echo Press Ctrl+C to stop the server
echo ============================================================
echo.

python server.py

pause
