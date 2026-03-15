# Kids Music Player 🎵

A simple, kid-friendly web application for playing music. Features a colorful grid of song thumbnails that kids can tap to play songs. No complicated buttons or controls - just tap and play!

## Features

- 🎨 Colorful, kid-friendly interface
- 📱 Touch-friendly grid layout
- 🎵 Simple tap-to-play interaction
- ✨ Visual feedback when songs are playing
- 📱 Responsive design for tablets and phones
- 🚫 No complicated controls or buttons

## Project Structure

```
kidsplayer/
├── index.html              # Main application file
├── songs.json             # Song configuration (optional)
├── assets/
│   ├── songs/            # Place your MP3 files here
│   │   ├── song1.mp3
│   │   ├── song2.mp3
│   │   └── ...
│   └── thumbnails/       # Place your thumbnail images here
│       ├── song1.jpg
│       ├── song2.jpg
│       └── ...
└── README.md
```

## Setup Instructions

### 1. Add Your Songs

1. Copy your MP3 audio files to the `assets/songs/` folder
2. Name them: `song1.mp3`, `song2.mp3`, `song3.mp3`, etc.

### 2. Add Thumbnails

1. Create or find thumbnail images for each song (JPG, PNG, or GIF)
2. Copy them to the `assets/thumbnails/` folder
3. Name them to match your songs: `song1.jpg`, `song2.jpg`, etc.
4. Recommended size: 500x500 pixels or larger

### 3. Configure Songs

Edit the `songs.json` file in the project root:

```json
[
  {
    "id": "song1",
    "title": "Happy Song",
    "audioFile": "song1.mp3",
    "thumbnail": "song1.jpg"
  },
  {
    "id": "song2",
    "title": "Dance Time",
    "audioFile": "song2.mp3",
    "thumbnail": "song2.jpg"
  }
]
```

- `id`: Unique identifier for the song
- `title`: The display name shown to kids
- `audioFile`: The MP3 filename in `assets/songs/`
- `thumbnail`: The image filename in `assets/thumbnails/`

## Running Locally (Testing)

### Option 1: Python (easiest)

If you have Python installed:

```bash
# Python 3
python -m http.server 8000

# Python 2
python -m SimpleHTTPServer 8000
```

Then open: `http://localhost:8000`

### Option 2: Node.js

```bash
npx http-server -p 8000
```

### Option 3: PHP

```bash
php -S localhost:8000
```

## Deploying on Raspberry Pi

### Prerequisites

- Raspberry Pi (any model with network connectivity)
- Raspberry Pi OS installed
- Network connection (WiFi or Ethernet)

### Installation Steps

1. **Update your Raspberry Pi:**

```bash
sudo apt update
sudo apt upgrade -y
```

2. **Install a web server (choose one):**

**Option A: Nginx (Recommended)**

```bash
sudo apt install nginx -y
```

**Option B: Apache**

```bash
sudo apt install apache2 -y
```

3. **Copy the application:**

**For Nginx:**
```bash
sudo cp -r /path/to/kidsplayer/* /var/www/html/
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/
```

**For Apache:**
```bash
sudo cp -r /path/to/kidsplayer/* /var/www/html/
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/
```

4. **Start the web server:**

**Nginx:**
```bash
sudo systemctl start nginx
sudo systemctl enable nginx
```

**Apache:**
```bash
sudo systemctl start apache2
sudo systemctl enable apache2
```

5. **Find your Raspberry Pi's IP address:**

```bash
hostname -I
```

6. **Access the app:**

From any device on your local network, open a web browser and go to:
```
http://[YOUR_PI_IP_ADDRESS]
```

For example: `http://192.168.1.100`

### Optional: Set a Static IP

To always access your Pi at the same address:

1. Edit the DHCP config:
```bash
sudo nano /etc/dhcpcd.conf
```

2. Add at the end:
```
interface wlan0
static ip_address=192.168.1.100/24
static routers=192.168.1.1
static domain_name_servers=192.168.1.1
```

3. Restart:
```bash
sudo reboot
```

## Customization

### Change Colors

Edit the CSS in `index.html`:

```css
body {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    /* Change these hex colors */
}
```

### Change Grid Size

Adjust the grid template in the CSS (in `index.html`):

```css
.grid {
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    /* Change 250px to make cards bigger/smaller */
}
```

### Change Title

Edit the `<h1>` tag in `index.html`:

```html
<h1>🎵 My Music 🎵</h1>
```

### Add or Remove Songs

Simply edit `songs.json` - add or remove song objects. The app will automatically load all songs from this file.

## Supported Audio Formats

- MP3 (recommended - best compatibility)
- WAV
- OGG
- M4A

## Supported Image Formats

- JPG/JPEG (recommended)
- PNG
- GIF
- WebP
- JIFF/JFIF

## Troubleshooting

### Songs won't play
- Check that audio files are in `assets/songs/` folder
- Verify filenames in `songs.json` match actual files exactly (case-sensitive on Linux/Pi)
- Ensure MP3 format is used
- Make sure `songs.json` exists and is valid JSON
- Check browser console for errors (F12)

### Thumbnails don't show
- Verify images are in `assets/thumbnails/` folder
- Check filenames in `songs.json` match actual image files
- A colored placeholder will show if image is missing

### Can't access from other devices
- Verify the Pi is on the same network
- Check firewall settings
- Ensure web server is running: `sudo systemctl status nginx`

### Permission errors on Pi
- Run: `sudo chmod -R 755 /var/www/html/`
- Run: `sudo chown -R www-data:www-data /var/www/html/`

## Browser Compatibility

- Chrome/Chromium (recommended)
- Firefox
- Safari
- Edge
- Any modern mobile browser

## Tips

- Use bright, colorful images that kids will recognize
- Keep song titles short and simple
- Test on a tablet in kiosk mode for a dedicated music player
- Consider using a tablet stand for easy access

## License

Free to use and modify for personal and educational purposes.

Enjoy! 🎉