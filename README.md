# 🎬 Resolve SRT → Fusion Titles (Auto Styled)

Automate subtitle import in **DaVinci Resolve** by converting `.srt` files into **Fusion Text+ titles** directly on the timeline — with randomized font styling and proper timing.

---

## 🚀 What This Does

This script:

* Reads an `.srt` subtitle file
* Converts timestamps into timeline frames
* Automatically inserts **Text+ (Fusion Titles)**
* Places them precisely on the timeline
* Applies **random font styling (4:1 ratio)**
* Adds background styling for readability
* Keeps everything clean and organized in a new video track

---

## ✨ Features

* 🎯 Frame-accurate subtitle placement
* 🎨 Random font selection (Ink Free vs Mistral, 80/20 split)
* 🧼 Cleans multi-line subtitles into single-line text
* 🎥 Automatically creates and uses a new video track
* ⚡ Fully automated — no manual subtitle placement needed

---

## 🧠 Use Case

Perfect for:

* YouTube shorts/Instagram Reels/Tiktok automation workflows
* Short-form content (Reels, Shorts, TikTok)
* Fast subtitle styling without editing each clip manually
* Creators using **Fusion Text+ for aesthetic subtitles**

---

## 📦 Requirements

* 🖥️ **DaVinci Resolve (Studio or Free)**
* Fusion Titles (Text+) available
* Lua scripting enabled

---

## ⚙️ Setup

1. Open **DaVinci Resolve**
2. Go to:

   ```
   Workspace → Scripts → Script Console
   ```
3. Paste this script OR save it in:

   ```
   DaVinci Resolve/Fusion/Scripts/Comp/
   ```
4. Update this line with your SRT file path:

   ```lua
   local srtPath = "C:/path/to/your/file.srt"
   ```

---

## ▶️ How to Use

1. Open your project and timeline
2. Run the script
3. The script will:

   * Disable existing video tracks temporarily
   * Create a new track
   * Insert styled subtitles automatically
4. Done ✅

Check the **newly created track** for your subtitles.

---

## 🎨 Styling Logic

* **Font Distribution (Randomized):**

  * 80% → Ink Free
  * 20% → Mistral

* Background enabled for readability:

  * Opacity: 0.7
  * Positioned at bottom (vertical justification)

---

## ⚠️ Notes

* Ensure your `.srt` file is properly formatted
* Timeline must be active before running
* Fonts must exist on your system

---

## 🛠️ Possible Improvements

* Add font packs dynamically
* Multi-line subtitle formatting
* Per-word animation (karaoke style)
* Subtitle positioning presets

---

## 🤝 Contributing

Feel free to fork and enhance:

* Add animation presets
* Improve styling logic
* Expand font randomness

---

## 📜 License

MIT License — use freely in your projects.

---

## 💡 Author Note

Built for creators who want **fast, aesthetic subtitles without manual effort**.

If you're making content at scale — this saves hours.

---
