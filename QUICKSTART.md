# Quick Start Guide 🚀

Get your Kids Music Player running in 5 minutes!

## What You Need

- Your song files (MP3 format)
- Thumbnail images for each song (JPG, PNG, etc.)
- A web browser or Raspberry Pi

## Quick Setup (3 Steps)

### Step 1: Add Your Media Files

Copy your files into the project folders:

```
kidsplayer/
├── assets/
│   ├── songs/
│   │   ├── song1.mp3       ← Your MP3 files here
│   │   ├── song2.mp3
│   │   └── song3.mp3
│   └── thumbnails/
│       ├── song1.jpg       ← Your thumbnail images here
│       ├── song2.jpg
│       └── song3.jpg
```

**Important:** The filename (without extension) must match for each pair!
- `song1.mp3` pairs with `song1.jpg`
- `song2.mp3` pairs with `song2.jpg`
- etc.

### Step 2: Edit the Song List

Open `songs.json` in the project root and update it:

```json
[
  {
    "id": "song1",
    "title": "Twinkle Twinkle",
    "audioFile": "song1.mp3",
    "thumbnail": "song1.jpg"
  },
  {
    "id": "song2",
    "title": "ABC Song",
    "audioFile": "song2.mp3",
    "thumbnail": "song2.jpg"
  },
  {
    "id": "song3",
    "title": "Wheels on Bus",
    "audioFile": "song3.mp3",
    "thumbnail": "song3.jpg"
  }
]
```

- `id`: Unique identifier for each song
- `title`: What kids will see on screen
- `audioFile`: The MP3 filename in `assets/songs/`
- `thumbnail`: The image filename in `assets/thumbnails/`

### Step 3: Run It!

**On Windows:**
```
Double-click: start-server.bat
```

**On Mac/Linux/Raspberry Pi:**
```bash
chmod +x start-server.sh
./start-server.sh
```

**Or use Python directly:**
```bash
python server.py
```

Then open your browser to: **http://localhost:8000**

That's it! 🎉

---

## Deploy to Raspberry Pi

### Quick Deploy (One Command)

On your Raspberry Pi, run:

```bash
chmod +x deploy-to-pi.sh
./deploy-to-pi.sh
```

This will:
- Install Nginx web server
- Deploy your application
- Start the server
- Show you the IP address to access it

### Manual Deploy

1. Install web server:
   ```bash
   sudo apt update
   sudo apt install nginx -y
   ```

2. Copy files:
   ```bash
   sudo cp -r /path/to/kidsplayer/* /var/www/html/
   sudo chown -R www-data:www-data /var/www/html/
   sudo chmod -R 755 /var/www/html/
   ```

3. Start server:
   ```bash
   sudo systemctl start nginx
   sudo systemctl enable nginx
   ```

4. Find your Pi's IP:
   ```bash
   hostname -I
   ```

5. Access from any device: `http://YOUR_PI_IP`

---

## Common Issues

**Songs won't play?**
- Check files are named correctly (e.g., `song1.mp3`)
- Ensure they're in the `assets/songs/` folder
- Use MP3 format

**No thumbnails showing?**
- Check files are in `assets/thumbnails/` folder
- Ensure filenames match (e.g., `song1.jpg` for `song1.mp3`)
- Don't worry - colored placeholders will show if images are missing

**Can't access from tablet/phone?**
- Make sure all devices are on the same WiFi network
- Use the IP address shown by the server
- Check firewall settings

---

## Pro Tips

✨ **Use colorful, bright images** that kids can easily recognize

✨ **Keep titles short** - one or two words work best

✨ **Test on the device kids will use** (tablet, phone, etc.)

✨ **Set up a tablet in kiosk mode** for a dedicated music player

---

Need more details? Check out the full **README.md** file!

Happy playing! 🎵🎉