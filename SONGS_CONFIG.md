# Songs Configuration Guide 🎵

This guide explains how to configure songs for the Kids Music Player using the `songs.json` file.

---

## 📋 Overview

The Kids Music Player loads all song information from the `songs.json` file located in the project root. This makes it easy to add, edit, or remove songs without modifying any code.

---

## 📁 File Location

```
kidsplayer/
├── songs.json          ← Edit this file
├── index.html
└── assets/
    ├── songs/          ← Your MP3 files
    └── thumbnails/     ← Your images
```

---

## 🎯 Basic Structure

The `songs.json` file is a JSON array containing song objects:

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

---

## 🔧 Field Definitions

Each song object has 4 fields:

### `id` (required)
- **Type:** String
- **Purpose:** Unique identifier for the song
- **Rules:**
  - Must be unique across all songs
  - Can contain letters, numbers, hyphens, underscores
  - No spaces allowed
  - Case-sensitive

**Examples:**
```json
"id": "song1"
"id": "twinkle-stars"
"id": "abc_song"
"id": "track-001"
```

### `title` (required)
- **Type:** String
- **Purpose:** Display name shown to kids
- **Rules:**
  - Can contain any characters (including spaces, emojis, Chinese characters, etc.)
  - Keep it short and simple for kids
  - 1-3 words works best

**Examples:**
```json
"title": "Happy Song"
"title": "Twinkle Twinkle Little Star"
"title": "一只哈巴狗"
"title": "ABC Song 🎵"
```

### `audioFile` (required)
- **Type:** String
- **Purpose:** Filename of the MP3 audio file
- **Rules:**
  - Must exist in `assets/songs/` folder
  - Include the file extension (`.mp3`)
  - Case-sensitive on Linux/Raspberry Pi
  - Can be any valid filename

**Examples:**
```json
"audioFile": "song1.mp3"
"audioFile": "twinkle-twinkle.mp3"
"audioFile": "一只哈巴狗.mp3"
"audioFile": "Track 01 - Happy Song.mp3"
```

### `thumbnail` (optional but recommended)
- **Type:** String
- **Purpose:** Filename of the thumbnail image
- **Rules:**
  - Should exist in `assets/thumbnails/` folder
  - Include file extension (`.jpg`, `.png`, `.svg`, `.gif`, `.jiff`, `.jfif`)
  - Case-sensitive on Linux/Raspberry Pi
  - **If specified:** App loads this exact file, or shows placeholder if not found
  - **If omitted:** App tries `{id}.svg` → `{id}.jpg` → `{id}.jiff` → `{id}.jfif` → `{id}.png` → placeholder

**Examples:**
```json
"thumbnail": "song1.jpg"
"thumbnail": "happy-song.png"
"thumbnail": "一只哈巴狗.jpg"
"thumbnail": "一只哈巴狗.jiff"
"thumbnail": "song1.svg"
```

**Note:** You can omit the `thumbnail` field entirely if your image files are named to match the song ID:
```json
{
  "id": "song1",
  "title": "Happy Song",
  "audioFile": "happy.mp3"
  // No thumbnail field - will automatically try song1.svg, song1.jpg, etc.
}
```

---

## 📝 Complete Example

Here's a complete example with 6 songs:

```json
[
  {
    "id": "song1",
    "title": "Twinkle Stars",
    "audioFile": "twinkle-twinkle.mp3",
    "thumbnail": "twinkle-stars.jpg"
  },
  {
    "id": "song2",
    "title": "ABC Song",
    "audioFile": "abc-song.mp3",
    "thumbnail": "abc-song.jpg"
  },
  {
    "id": "song3",
    "title": "Wheels on Bus",
    "audioFile": "wheels-on-the-bus.mp3",
    "thumbnail": "wheels-bus.jpg"
  },
  {
    "id": "song4",
    "title": "Baby Shark",
    "audioFile": "baby-shark.mp3",
    "thumbnail": "baby-shark.jpg"
  },
  {
    "id": "song5",
    "title": "Old MacDonald",
    "audioFile": "old-macdonald.mp3",
    "thumbnail": "old-macdonald.jpg"
  },
  {
    "id": "song6",
    "title": "Happy Birthday",
    "audioFile": "happy-birthday.mp3",
    "thumbnail": "happy-birthday.jpg"
  }
]
```

---

## ➕ Adding New Songs

### Step 1: Add the Files
```bash
# Copy MP3 to songs folder
cp "new-song.mp3" assets/songs/

# Copy thumbnail to thumbnails folder
cp "new-song.jpg" assets/thumbnails/
```

### Step 2: Edit songs.json

Add a new object to the array:

```json
[
  {
    "id": "song1",
    "title": "Happy Song",
    "audioFile": "song1.mp3",
    "thumbnail": "song1.jpg"
  },
  {
    "id": "new-song",
    "title": "My New Song",
    "audioFile": "new-song.mp3",
    "thumbnail": "new-song.jpg"
  }
]
```

**Important:** Don't forget the comma between objects!

### Step 3: Refresh Browser

Hard refresh the page:
- **Windows:** Ctrl + F5
- **Mac:** Cmd + Shift + R
- **Mobile:** Clear cache and reload

---

## ✏️ Editing Songs

To change a song's display name:

```json
{
  "id": "song1",
  "title": "Updated Title Here",  ← Just change this
  "audioFile": "song1.mp3",
  "thumbnail": "song1.jpg"
}
```

To use a different audio file:

```json
{
  "id": "song1",
  "title": "Happy Song",
  "audioFile": "better-version.mp3",  ← Change this
  "thumbnail": "song1.jpg"
}
```

---

## ❌ Removing Songs

Simply delete the song object from the array:

**Before:**
```json
[
  {
    "id": "song1",
    "title": "Keep This",
    "audioFile": "song1.mp3",
    "thumbnail": "song1.jpg"
  },
  {
    "id": "song2",
    "title": "Delete This",
    "audioFile": "song2.mp3",
    "thumbnail": "song2.jpg"
  },
  {
    "id": "song3",
    "title": "Keep This Too",
    "audioFile": "song3.mp3",
    "thumbnail": "song3.jpg"
  }
]
```

**After:**
```json
[
  {
    "id": "song1",
    "title": "Keep This",
    "audioFile": "song1.mp3",
    "thumbnail": "song1.jpg"
  },
  {
    "id": "song3",
    "title": "Keep This Too",
    "audioFile": "song3.mp3",
    "thumbnail": "song3.jpg"
  }
]
```

**Note:** Make sure to remove the comma after the last object!

---

## 🌍 International Characters

The app fully supports Unicode characters:

### Chinese Example:
```json
[
  {
    "id": "song1",
    "title": "一只哈巴狗",
    "audioFile": "一只哈巴狗.mp3",
    "thumbnail": "一只哈巴狗.jpg"
  },
  {
    "id": "song2",
    "title": "两只老虎",
    "audioFile": "两只老虎.mp3",
    "thumbnail": "两只老虎.jpg"
  }
]
```

### Spanish Example:
```json
[
  {
    "id": "song1",
    "title": "Feliz Cumpleaños",
    "audioFile": "cumpleanos.mp3",
    "thumbnail": "cumpleanos.jpg"
  }
]
```

### With Emojis:
```json
[
  {
    "id": "song1",
    "title": "Happy Song 😊",
    "audioFile": "happy.mp3",
    "thumbnail": "happy.jpg"
  },
  {
    "id": "song2",
    "title": "🌟 Twinkle Stars",
    "audioFile": "twinkle.mp3",
    "thumbnail": "twinkle.jpg"
  }
]
```

---

## 🔍 JSON Syntax Rules

### ✅ Valid JSON:
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

### ❌ Invalid JSON (common mistakes):

**Missing comma:**
```json
[
  {
    "id": "song1",
    "title": "Happy Song"
    "audioFile": "song1.mp3"  ← Missing comma!
  }
]
```

**Trailing comma:**
```json
[
  {
    "id": "song1",
    "title": "Happy Song",
    "audioFile": "song1.mp3",
    "thumbnail": "song1.jpg",  ← Remove this comma!
  }
]
```

**Single quotes instead of double quotes:**
```json
[
  {
    'id': 'song1',  ← Use double quotes!
    'title': 'Happy Song'
  }
]
```

---

## 🧪 Testing Your Configuration

### Method 1: Browser Console
1. Open your browser (F12)
2. Go to Console tab
3. Load the page
4. Look for any errors

### Method 2: JSON Validator
Use an online validator:
- JSONLint.com
- JSONFormatter.org
- Paste your JSON and check for errors

### Method 3: Command Line
```bash
# On Linux/Mac/Raspberry Pi
cat songs.json | python -m json.tool

# Should output formatted JSON if valid
# Shows error if invalid
```

---

## 📊 Organization Tips

### Group by Category

You can organize songs by adding them in logical groups:

```json
[
  // Nursery Rhymes
  {
    "id": "song1",
    "title": "Twinkle Stars",
    "audioFile": "twinkle.mp3",
    "thumbnail": "twinkle.jpg"
  },
  {
    "id": "song2",
    "title": "Wheels on Bus",
    "audioFile": "wheels.mp3",
    "thumbnail": "wheels.jpg"
  },
  
  // Educational
  {
    "id": "song3",
    "title": "ABC Song",
    "audioFile": "abc.mp3",
    "thumbnail": "abc.jpg"
  },
  {
    "id": "song4",
    "title": "Count to 10",
    "audioFile": "counting.mp3",
    "thumbnail": "counting.jpg"
  }
]
```

**Note:** Comments are not valid in JSON files, but you can use them while editing and remove before saving.

### Alphabetical Order
```json
[
  {
    "id": "song1",
    "title": "ABC Song",
    "audioFile": "abc.mp3",
    "thumbnail": "abc.jpg"
  },
  {
    "id": "song2",
    "title": "Baby Shark",
    "audioFile": "baby-shark.mp3",
    "thumbnail": "baby-shark.jpg"
  },
  {
    "id": "song3",
    "title": "Wheels on Bus",
    "audioFile": "wheels.mp3",
    "thumbnail": "wheels.jpg"
  }
]
```

---

## 🚨 Troubleshooting

### Error: "Could not load songs"

**Possible causes:**
1. `songs.json` file doesn't exist
2. `songs.json` has invalid JSON syntax
3. File is in wrong location

**Solution:**
- Check file exists in project root (same folder as `index.html`)
- Validate JSON syntax
- Check browser console (F12) for specific error

### Songs Don't Play

**Possible causes:**
1. Audio file doesn't exist
2. `audioFile` name doesn't match actual filename
3. Wrong folder (should be in `assets/songs/`)

**Solution:**
```bash
# Check if file exists
ls assets/songs/

# Verify exact filename
ls assets/songs/ | grep "song1"
```

### Thumbnails Missing

**Possible causes:**
1. Image file doesn't exist
2. `thumbnail` name doesn't match actual filename
3. Wrong folder (should be in `assets/thumbnails/`)

**Solution:**
- Check file exists in `assets/thumbnails/`
- Verify exact filename (case-sensitive on Linux/Pi)
- Don't worry - colorful placeholders will show if missing!

### Special Characters Not Working

**Solution:**
Make sure your `songs.json` file is saved with **UTF-8 encoding**:

- **VS Code:** Bottom right corner → select UTF-8
- **Notepad++:** Encoding → Convert to UTF-8
- **Notepad:** Save As → Encoding: UTF-8

---

## 💡 Best Practices

### ✅ DO:
- Use consistent naming conventions
- Keep titles short and simple
- Test after every change
- Back up your `songs.json` file
- Use descriptive IDs
- Save file with UTF-8 encoding

### ❌ DON'T:
- Use special characters in IDs (use title instead)
- Make IDs too long
- Forget commas between objects
- Leave trailing commas
- Use single quotes
- Hard-code file paths

---

## 📦 Example Files

### Simple Example (3 songs):
```json
[
  {
    "id": "song1",
    "title": "Happy Song",
    "audioFile": "happy.mp3",
    "thumbnail": "happy.jpg"
  },
  {
    "id": "song2",
    "title": "Dance Time",
    "audioFile": "dance.mp3",
    "thumbnail": "dance.jpg"
  },
  {
    "id": "song3",
    "title": "Sweet Dreams",
    "audioFile": "dreams.mp3",
    "thumbnail": "dreams.jpg"
  }
]
```

### Large Collection (12 songs):
See the default `songs.json` file in the project for a complete example with 12 Chinese children's songs.

---

## 🔗 Related Files

- `songs.example.json` - Simple English example
- `README.md` - Complete project documentation
- `QUICKSTART.md` - Quick setup guide
- `TROUBLESHOOTING.md` - Common issues and solutions

---

**Happy configuring! 🎵** Add as many songs as you want - the app will automatically display them all!