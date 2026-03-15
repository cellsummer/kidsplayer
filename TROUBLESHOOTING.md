# Troubleshooting Guide 🔧

Quick fixes for common issues with Kids Music Player.

---

## 🎵 Sound Issues

### Problem: Songs Won't Play at All

**Checklist:**
- [ ] Are MP3 files in the `assets/songs/` folder?
- [ ] Do filenames match the song IDs exactly? (case-sensitive on Linux/Pi)
- [ ] Is the audio file corrupted? (try playing it outside the app)
- [ ] Is your browser blocking autoplay? (some browsers require user interaction first)
- [ ] Check browser console for errors (press F12)

**Solution:**
```bash
# Verify files exist
ls -la assets/songs/

# Check file permissions (on Pi)
sudo chmod 644 assets/songs/*.mp3

# Test a specific file
file assets/songs/song1.mp3  # Should say "MPEG" or "Audio"
```

### Problem: Some Songs Play, Others Don't

**Cause:** Usually a filename mismatch

**Solution:**
1. Open browser console (F12)
2. Click the non-working song
3. Look for 404 error showing the expected filename
4. Rename your file to match exactly

**Example:**
```
Error: GET http://localhost:8000/assets/songs/song1.mp3 404 (Not Found)
→ Your file is probably named Song1.mp3 or SONG1.mp3
→ Rename to: song1.mp3
```

### Problem: Songs Stop Unexpectedly

**Common Causes:**
- File is corrupted
- Network interruption (if loading from slow connection)
- Browser tab went to sleep

**Solution:**
- Re-download or re-encode the MP3 file
- Keep the tab active/visible
- Reduce MP3 bitrate for smaller files

---

## 🖼️ Image Issues

### Problem: Thumbnails Don't Show

**Normal Behavior:**
- App shows colorful placeholders with 🎵 emoji
- This is expected when images are missing
- App still works perfectly!

**If You Want Real Images:**

**Checklist:**
- [ ] Are images in `assets/thumbnails/` folder?
- [ ] Do filenames match song IDs exactly?
- [ ] Are images valid formats? (JPG, PNG, GIF, WebP)
- [ ] Check file permissions (on Pi)

**Solution:**
```bash
# List thumbnails
ls -la assets/thumbnails/

# Fix permissions
sudo chmod 644 assets/thumbnails/*

# Test image validity
file assets/thumbnails/song1.jpg
```

### Problem: Images Load Slowly

**Cause:** Images are too large

**Solution:**
Resize images before uploading:
```bash
# Using ImageMagick (on Linux/Pi)
mogrify -resize 500x500 -quality 85 *.jpg

# Or use online tools:
# - TinyPNG.com
# - Squoosh.app
# - ResizeImage.net
```

---

## 🌐 Network/Access Issues

### Problem: Can't Access from Phone/Tablet

**Checklist:**
- [ ] Is Raspberry Pi powered on?
- [ ] Is the web server running?
- [ ] Are devices on the same WiFi network?
- [ ] Is firewall blocking port 80?
- [ ] Are you using the correct IP address?

**Diagnostic Steps:**

1. **Check if server is running:**
   ```bash
   sudo systemctl status nginx
   # Should say "active (running)"
   ```

2. **Find Raspberry Pi IP:**
   ```bash
   hostname -I
   # Use the first IP shown
   ```

3. **Test from Pi itself:**
   ```bash
   curl http://localhost
   # Should return HTML
   ```

4. **Test from another device:**
   - Ping the Pi: `ping 192.168.1.100` (use your Pi's IP)
   - Try browser: `http://192.168.1.100`

5. **Check firewall:**
   ```bash
   sudo ufw status
   
   # If blocking, allow HTTP:
   sudo ufw allow 80/tcp
   sudo ufw reload
   ```

### Problem: IP Address Keeps Changing

**Solution:** Set a static IP

1. Edit DHCP config:
   ```bash
   sudo nano /etc/dhcpcd.conf
   ```

2. Add at the end (adjust to your network):
   ```
   interface wlan0
   static ip_address=192.168.1.100/24
   static routers=192.168.1.1
   static domain_name_servers=8.8.8.8
   ```

3. Reboot:
   ```bash
   sudo reboot
   ```

### Problem: "Connection Refused" Error

**Cause:** Web server not running

**Solution:**
```bash
# Start Nginx
sudo systemctl start nginx

# Enable auto-start on boot
sudo systemctl enable nginx

# Check status
sudo systemctl status nginx
```

---

## 💻 Raspberry Pi Specific Issues

### Problem: Permission Denied Errors

**Solution:**
```bash
# Fix ownership
sudo chown -R www-data:www-data /var/www/html/

# Fix permissions
sudo chmod -R 755 /var/www/html/
sudo find /var/www/html/ -type f -exec chmod 644 {} \;
```

### Problem: "Address Already in Use"

**Cause:** Port 80 is being used by another service

**Solution:**
```bash
# Find what's using port 80
sudo netstat -tulpn | grep :80

# Stop Apache if it's running
sudo systemctl stop apache2
sudo systemctl disable apache2

# Start Nginx
sudo systemctl start nginx
```

### Problem: Changes Don't Appear After Update

**Solution:**
1. **Clear browser cache:**
   - Chrome: Ctrl+Shift+Delete
   - Safari: Cmd+Option+E
   - Or use incognito/private mode

2. **Hard refresh:**
   - Windows: Ctrl+F5
   - Mac: Cmd+Shift+R

3. **Verify files were actually copied:**
   ```bash
   ls -la /var/www/html/
   cat /var/www/html/index.html | grep "song1"
   ```

---

## 📱 Mobile/Tablet Issues

### Problem: Audio Doesn't Start on iOS

**Cause:** iOS requires user interaction before playing audio

**Solution:**
- This is normal browser behavior
- User must tap once to enable audio
- After first tap, everything works normally
- Can't be fixed in code (Apple security feature)

### Problem: Screen Keeps Turning Off

**Solution:**
- Enable "Guided Access" (iOS) or "Screen Pinning" (Android)
- Increase screen timeout in device settings
- Use "Keep Screen On" app
- Connect to power to prevent sleep

### Problem: Too Small on Tablet

**Solution:**
Adjust card size in `index.html`:
```css
.grid {
    grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
    /* Change 350px to make cards bigger */
}
```

---

## 🛠️ Development/Testing Issues

### Problem: Python Server Won't Start

**Error:** "Python not found"

**Solution:**
```bash
# Check Python installation
python --version
# or
python3 --version

# Install Python (Ubuntu/Debian/Raspberry Pi)
sudo apt install python3

# Install Python (Windows)
# Download from python.org
```

**Error:** "Port already in use"

**Solution:**
```bash
# Find and kill process using port 8000
# Linux/Mac:
lsof -ti:8000 | xargs kill -9

# Windows:
netstat -ano | findstr :8000
taskkill /PID <PID_NUMBER> /F

# Or use a different port:
python -m http.server 8080
```

### Problem: Changes to index.html Don't Show

**Solution:**
1. Save the file (Ctrl+S)
2. Hard refresh browser (Ctrl+F5 or Cmd+Shift+R)
3. Check file was actually saved
4. Make sure you're editing the right file

---

## 🔍 Debugging Tips

### Enable Browser Console

**Chrome/Edge/Firefox:**
- Press F12
- Click "Console" tab
- Refresh page
- Look for red error messages

**Safari:**
- Enable Developer Menu: Preferences → Advanced → Show Develop menu
- Develop → Show JavaScript Console

### Common Console Errors

**Error:** `GET http://localhost:8000/assets/songs/song1.mp3 404`
- **Fix:** File doesn't exist or wrong filename

**Error:** `Failed to load resource`
- **Fix:** Check file permissions and path

**Error:** `The play() request was interrupted`
- **Fix:** Normal on iOS, user must tap first

### Check Server Logs

**Nginx:**
```bash
# Error log
sudo tail -f /var/log/nginx/error.log

# Access log
sudo tail -f /var/log/nginx/access.log
```

**Python Server:**
- Errors appear directly in terminal where you ran `python server.py`

---

## 📋 Configuration Checklist

Use this checklist when setting up a new song:

- [ ] MP3 file copied to `assets/songs/`
- [ ] Thumbnail image copied to `assets/thumbnails/`
- [ ] Both files have matching names (e.g., `song1.mp3` and `song1.jpg`)
- [ ] Song added to `songs` array in `index.html`
- [ ] ID in array matches filenames
- [ ] File permissions set correctly (if on Pi)
- [ ] Browser cache cleared
- [ ] Page hard-refreshed

---

## 🆘 Still Not Working?

### Gather Information

1. **What's the exact error message?** (check browser console)
2. **What device are you using?** (Pi, PC, tablet?)
3. **What browser?** (Chrome, Safari, Firefox?)
4. **Did it ever work?** (or is this first setup?)
5. **What changed?** (updated software, moved files?)

### Quick Diagnostic

Run this on your Raspberry Pi:
```bash
echo "=== System Check ==="
echo "Web server status:"
sudo systemctl status nginx | head -5
echo ""
echo "Files present:"
ls -lh /var/www/html/index.html
ls -lh /var/www/html/assets/songs/ | head -5
ls -lh /var/www/html/assets/thumbnails/ | head -5
echo ""
echo "IP Address:"
hostname -I
echo ""
echo "Disk space:"
df -h /var/www/html/
```

### Reset to Clean State

If all else fails, redeploy:
```bash
cd /path/to/kidsplayer
./deploy-to-pi.sh
```

Or manual reset:
```bash
# Backup current setup
sudo cp -r /var/www/html /var/www/html.backup

# Clear and redeploy
sudo rm -rf /var/www/html/*
sudo cp -r /path/to/kidsplayer/* /var/www/html/
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/
sudo systemctl restart nginx
```

---

## ✅ Prevention Tips

### Best Practices

1. **Use consistent naming:**
   - All lowercase
   - No spaces (use dashes: `my-song.mp3`)
   - Keep names short and simple

2. **Test before deploying:**
   - Run locally with Python server first
   - Test one song before adding all songs

3. **Keep backups:**
   - Backup your songs/images before uploading to Pi
   - Save a copy of working `index.html`

4. **Document your setup:**
   - Write down your Pi's IP address
   - Note which songs are which IDs
   - Keep a list of troubleshooting steps that worked for you

5. **Regular maintenance:**
   - Restart Pi monthly
   - Update software quarterly
   - Clean up old backups

---

**Remember:** The app is designed to be simple and forgiving. Most issues are quick fixes! 🎵