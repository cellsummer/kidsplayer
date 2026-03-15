# Songs Folder

Place your audio files (MP3 format) here.

## File Naming

Name your audio files to match the song IDs in the main `index.html` file:

- `song1.mp3`
- `song2.mp3`
- `song3.mp3`
- `song4.mp3`
- etc.

## Supported Formats

- **MP3** (recommended - best compatibility)
- WAV
- OGG
- M4A

## Example

If you have a song configured in `index.html` as:

```javascript
{ id: 'happy-birthday', title: 'Happy Birthday' }
```

Then your audio file should be named:
```
happy-birthday.mp3
```

## Tips

- Keep file sizes reasonable (under 10MB per song)
- Use consistent audio quality (128-320 kbps for MP3)
- Test audio files before deploying
- Make sure filenames match exactly (case-sensitive on Linux/Raspberry Pi)