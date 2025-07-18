# appversal_assignment


# 📱 Flutter Picture-in-Picture (PiP) Video Player

A modern Flutter app demonstrating a floating Picture-in-Picture (PiP) video player with draggable positioning, full-screen toggle, mute/unmute, and auto-hide controls. Built with smooth UX, state management, and responsiveness in mind.

---

## 🚀 Features

- 🖼️ **Floating PiP Player** (300×200) - draggable and resizable
- 🖥️ **Full-screen Toggle** - with smooth transition and hidden AppBar
- 🔇 **Mute/Unmute** - with visual feedback
- ⏯️ **Play/Pause**, double-tap to seek
- 🛑 **Close PiP** and 🧩 **Restore PiP**
- 🔄 **Buffering Indicator**
- 🌙 **Dark Mode**
- 👆 **Pinch to Resize PiP** (Bonus)

---

## 📁 Project Structure

```

## 📁 Project Structure
The project follows a modular architecture:

```
lib/
├── main.dart # App entry point
├── app.dart # App scaffold and layout
├── views/         
     ├── pip_video_player.dart # PiP UI, gestures, controls
├──  viewmodels/
│   └── video_player_viewmodel.dart # State management and video logic
├── assets/           # Core functionality
│   ├── sample_video.mp4 # Sample local video

```  
## 🛠️ Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone https://github.com/shahiyan7/pip_video_player.git
   cd pip_video_player
   ```

2. **Install Dependencies**

   ```bash
   flutter pub get
   ```

3. **Add Sample Video**

   * Place a sample video file in `assets/`
   * Example: `assets/sample_video.mp4`
   * Ensure it's listed in `pubspec.yaml`:

     ```yaml
     flutter:
       assets:
         - assets/sample_video.mp4
     ```

4. **Run the App**

   ```bash
   flutter run
   ```

---

## 📸 Screenshots

<div align="center" style="display: flex; justify-content: space-between; gap: 8px;">
   <img src="https://github.com/shahiyan7/appversal_assignment/blob/main/screenshots/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202025-07-17%20at%2017.12.03.png" width="16.66%" alt=>
    <img src="https://github.com/shahiyan7/appversal_assignment/blob/main/screenshots/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202025-07-17%20at%2017.12.56.png" width="16.66%" alt=>
     <img src="https://github.com/shahiyan7/appversal_assignment/blob/main/screenshots/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202025-07-17%20at%2017.11.41.png" width="16.66%" alt=>
  
</div>

---

## 🧠 Implementation Summary

* **State Management**: Used `ChangeNotifier` via `Provider`
* **Video Control**: `video_player` package for playback
* **PiP Positioning**: Via `Offset` and `GestureDetector`
* **Resizing**: Pinch gestures with clamped min/max bounds
* **Responsiveness**: Handles screen sizes, orientation changes
* **UX**: Auto-hide controls, persistent playback, and buffer handling

---

