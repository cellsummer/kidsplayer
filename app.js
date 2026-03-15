// Kids Music Player - Main Application
// Loads songs from songs.json and creates interactive music player

const audioPlayer = document.getElementById("audioPlayer");
const songsGrid = document.getElementById("songsGrid");
let currentCard = null;
let songs = [];

// Load songs from JSON file
async function loadSongs() {
    try {
        const response = await fetch("songs.json");
        if (!response.ok) {
            throw new Error("Failed to load songs.json");
        }
        songs = await response.json();
        createSongCards();
    } catch (error) {
        console.error("Error loading songs:", error);
        // Show error message to user
        songsGrid.innerHTML = `
            <div style="grid-column: 1/-1; text-align: center; padding: 40px; color: white; font-size: 1.5em;">
                ⚠️ Could not load songs. Please make sure songs.json exists.
            </div>
        `;
    }
}

// Create song cards
function createSongCards() {
    songs.forEach((song) => {
        const card = document.createElement("div");
        card.className = "song-card";
        card.dataset.songId = song.id;

        const img = document.createElement("img");
        // Use thumbnail from JSON
        const thumbnailFile = song.thumbnail;
        img.src = thumbnailFile
            ? `assets/thumbnails/${thumbnailFile}`
            : `assets/thumbnails/${song.id}.svg`;
        img.alt = song.title;

        // Fallback logic:
        // - If thumbnail specified in JSON: try that file -> placeholder
        // - If no thumbnail in JSON: try svg -> jpg -> jiff -> jfif -> png -> placeholder
        let fallbackAttempted = 0;
        img.onerror = function () {
            if (song.thumbnail) {
                // Thumbnail was specified but failed to load
                // Go straight to placeholder
                this.src =
                    'data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" width="250" height="250"%3E%3Crect fill="%23' +
                    getRandomColor() +
                    '" width="250" height="250"/%3E%3Ctext x="50%25" y="50%25" font-size="60" text-anchor="middle" dy=".3em" fill="white"%3E🎵%3C/text%3E%3C/svg%3E';
            } else {
                // No thumbnail specified, try common extensions
                if (fallbackAttempted === 0) {
                    // Try JPG
                    fallbackAttempted = 1;
                    this.src = `assets/thumbnails/${song.id}.jpg`;
                } else if (fallbackAttempted === 1) {
                    // Try JIFF
                    fallbackAttempted = 2;
                    this.src = `assets/thumbnails/${song.id}.jiff`;
                } else if (fallbackAttempted === 2) {
                    // Try JFIF
                    fallbackAttempted = 3;
                    this.src = `assets/thumbnails/${song.id}.jfif`;
                } else if (fallbackAttempted === 3) {
                    // Try PNG
                    fallbackAttempted = 4;
                    this.src = `assets/thumbnails/${song.id}.png`;
                } else {
                    // Show placeholder
                    this.src =
                        'data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" width="250" height="250"%3E%3Crect fill="%23' +
                        getRandomColor() +
                        '" width="250" height="250"/%3E%3Ctext x="50%25" y="50%25" font-size="60" text-anchor="middle" dy=".3em" fill="white"%3E🎵%3C/text%3E%3C/svg%3E';
                }
            }
        };

        const title = document.createElement("div");
        title.className = "song-title";
        title.textContent = song.title;

        card.appendChild(img);
        card.appendChild(title);
        card.addEventListener("click", () => playSong(song, card));

        songsGrid.appendChild(card);
    });
}

// Play or pause a song
function playSong(song, card) {
    // If clicking the same song that's playing, pause it
    if (currentCard === card && !audioPlayer.paused) {
        audioPlayer.pause();
        card.classList.remove("playing");
        currentCard = null;
        return;
    }

    // Remove playing state from previous card
    if (currentCard) {
        currentCard.classList.remove("playing");
    }

    // Set new song - use audioFile from JSON or fallback to id.mp3
    const audioFile = song.audioFile || `${song.id}.mp3`;
    audioPlayer.src = `assets/songs/${audioFile}`;
    audioPlayer.play();
    card.classList.add("playing");
    currentCard = card;
}

// Remove playing state when song ends
audioPlayer.addEventListener("ended", () => {
    if (currentCard) {
        currentCard.classList.remove("playing");
        currentCard = null;
    }
});

// Generate random color for placeholder
function getRandomColor() {
    const colors = [
        "FF6B6B",
        "4ECDC4",
        "45B7D1",
        "FFA07A",
        "98D8C8",
        "F7DC6F",
        "BB8FCE",
        "85C1E2",
    ];
    return colors[Math.floor(Math.random() * colors.length)];
}

// Initialize: Load songs when page loads
loadSongs();
