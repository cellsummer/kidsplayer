# Thumbnail Quick Reference Guide 🖼️

Quick guide for configuring thumbnails in Kids Music Player.

---

## 📋 Supported Formats

✅ **SVG** - Vector graphics (recommended for small file size)
✅ **JPG/JPEG** - Photos and images
✅ **PNG** - Images with transparency
✅ **GIF** - Animated images
✅ **WebP** - Modern compressed format
✅ **JIFF/JFIF** - JPEG File Interchange Format

---

## 🎯 How Thumbnails Load

### Option 1: Specify in songs.json (Recommended)

```json
{
  "id": "song1",
  "title": "Happy Song",
  "audioFile": "song1.mp3",
  "thumbnail": "happy-face.jpg"
}
```

**Behavior:** Loads `assets/thumbnails/happy-face.jpg` exactly
- ✅ Use any filename you want
- ✅ Supports Unicode filenames (Chinese, Spanish, etc.)
- ⚠️ If file not found, shows colorful placeholder

### Option 2: Omit from songs.json (Auto-detect)

```json
{
  "id": "song1",
  "title": "Happy Song",
  "audioFile": "song1.mp3"
}
```

**Behavior:** Automatically tries these files in order:
1. `assets/thumbnails/song1.svg`
2. `assets/thumbnails/song1.jpg`
3. `assets/thumbnails/song1.jiff`
4. `assets/thumbnails/song1.jfif`
5. `assets/thumbnails/song1.png`
6. Colorful placeholder (if none found)

---

## 📝 Examples

### Example 1: Simple English Songs
```json
[
  {
    "id": "twinkle",
    "title": "Twinkle Twinkle",
    "audioFile": "twinkle.mp3",
    "thumbnail": "star.jpg"
  }
]
```
**Files needed:**
- `assets/songs/twinkle.mp3`
- `assets/thumbnails/star.jpg`

### Example 2: Chinese Songs with JIFF
```json
[
  {
    "id": "song1",
    "title": "一只哈巴狗",
    "audioFile": "一只哈巴狗.mp3",
    "thumbnail": "一只哈巴狗.jiff"
  }
]
```
**Files needed:**
- `assets/songs/一只哈巴狗.mp3`
- `assets/thumbnails/一只哈巴狗.jiff`

### Example 3: Mixed Formats
```json
[
  {
    "id": "song1",
    "title": "Happy Song",
    "audioFile": "happy.mp3",
    "thumbnail": "happy.svg"
  },
  {
    "id": "song2",
    "title": "Dance Time",
    "audioFile": "dance.mp3",
    "thumbnail": "dance.jiff"
  },
  {
    "id": "song3",
    "title": "Bedtime",
    "audioFile": "bedtime.mp3",
    "thumbnail": "moon.png"
  }
]
```

### Example 4: Auto-detect (No thumbnail field)
```json
[
  {
    "id": "song1",
    "title": "Happy Song",
    "audioFile": "my-happy-song.mp3"
  }
]
```
**Will try to load (in order):**
- `song1.svg`
- `song1.jpg`
- `song1.jiff`
- `song1.jfif`
- `song1.png`

---

## 🔧 Quick Setup

### Step 1: Add Files
```bash
# Copy image to thumbnails folder
cp my-image.jpg assets/thumbnails/

# Copy audio to songs folder
cp my-song.mp3 assets/songs/
```

### Step 2: Edit songs.json
```json
{
  "id": "my-song",
  "title": "My Song Title",
  "audioFile": "my-song.mp3",
  "thumbnail": "my-image.jpg"
}
```

### Step 3: Test
```bash
python server.py
```
Open `http://localhost:8000`

---

## 💡 Pro Tips

### Tip 1: Use Descriptive Names
```json
✅ GOOD:
"thumbnail": "happy-face.jpg"
"thumbnail": "rocket-ship.png"

❌ BAD:
"thumbnail": "img1.jpg"
"thumbnail": "pic.jpg"
```

### Tip 2: Match ID for Auto-detect
```json
{
  "id": "abc-song",
  "title": "ABC Song",
  "audioFile": "alphabet.mp3"
  // No thumbnail - will auto-try abc-song.svg, abc-song.jpg, etc.
}
```
**Name your image:** `abc-song.jpg` or `abc-song.svg`

### Tip 3: Unicode Filenames Work!
```json
{
  "id": "song1",
  "title": "小星星",
  "audioFile": "小星星.mp3",
  "thumbnail": "小星星.jiff"
}
```
✅ Fully supported!

### Tip 4: Optimize File Sizes
- **SVG**: 3-10 KB (best for graphics)
- **JPG**: 50-200 KB (compress to 85% quality)
- **PNG**: 100-300 KB (use for transparency)
- **JIFF**: Similar to JPG

**Recommended:** Keep under 500 KB per image

---

## 🚨 Troubleshooting

### Problem: Thumbnail doesn't show

**Check:**
1. Is the file in `assets/thumbnails/` folder?
2. Does the filename match exactly? (case-sensitive on Linux/Pi)
3. Is the extension correct in songs.json?
4. Try opening the image file directly to verify it's not corrupted

**Test:**
```bash
# List thumbnails
ls assets/thumbnails/

# Check specific file
ls assets/thumbnails/song1.jpg
```

### Problem: Shows placeholder instead of image

**This means:**
- File doesn't exist, OR
- Filename doesn't match, OR
- File is corrupted

**Solutions:**
1. Check exact filename (including extension)
2. Verify file exists in correct folder
3. Check browser console (F12) for 404 errors
4. Try opening image in browser directly

### Problem: JIFF file not loading

**Verify:**
1. Extension is `.jiff` or `.jfif` (not `.jif` or `.jpeg`)
2. File is actually JFIF format (some cameras save as this)
3. Try renaming to `.jpg` if uncertain

---

## 📊 File Format Comparison

| Format | Size | Quality | Transparency | Animation | Best For |
|--------|------|---------|--------------|-----------|----------|
| SVG | Tiny | Perfect | ✅ | ❌ | Icons, graphics |
| JPG | Small | Good | ❌ | ❌ | Photos |
| JIFF/JFIF | Small | Good | ❌ | ❌ | Photos from cameras |
| PNG | Medium | Excellent | ✅ | ❌ | Graphics with transparency |
| GIF | Medium | Fair | ✅ | ✅ | Animations |
| WebP | Small | Excellent | ✅ | ✅ | Modern web |

---

## ✅ Checklist

When adding a new song with thumbnail:

- [ ] Image file copied to `assets/thumbnails/`
- [ ] Audio file copied to `assets/songs/`
- [ ] Song entry added to `songs.json`
- [ ] `thumbnail` field matches actual filename exactly
- [ ] `audioFile` field matches actual filename exactly
- [ ] File extensions included (`.jpg`, `.mp3`, etc.)
- [ ] Unicode characters saved with UTF-8 encoding
- [ ] Browser cache cleared and page refreshed
- [ ] Tested in browser

---

## 🎨 Creating Thumbnails

### Quick Methods:

**1. Use the Generator:**
- Open `thumbnail-generator.html`
- Customize colors and text
- Download as JPG/PNG

**2. Take Screenshots:**
- Play song video
- Screenshot the best frame
- Crop to square (500x500px)
- Save to `assets/thumbnails/`

**3. Use Online Tools:**
- Canva.com (design custom images)
- Remove.bg (remove backgrounds)
- TinyPNG.com (compress files)

**4. From Photos:**
- Use photos from your phone/camera (JIFF files work!)
- Resize to 500x500px
- Copy to thumbnails folder
- Reference in songs.json

---

## 🔗 Related Files

- `songs.json` - Main configuration
- `SONGS_CONFIG.md` - Complete songs configuration guide
- `assets/THUMBNAILS_INFO.md` - Detailed thumbnail information
- `README.md` - Full project documentation

---

**Quick Reference Complete!** 🎉

For more details, see `SONGS_CONFIG.md` and `assets/THUMBNAILS_INFO.md`
