# 📱 LIKHA Android App

**Likha sa Wala Edition - Cloud Infrastructure Setup on Mobile**

LIKHA is a lightweight Android app that streamlines cloud infrastructure setup. Upon launch, it displays a terminal-like UI and automatically opens your browser to authenticate with all five cloud platforms.

## 📦 What's Inside

- **AndroidManifest.xml** - App configuration and permissions
- **MainActivity.kt** - Terminal-style UI with auto-opening browsers for OAuth
- **build.gradle.kts** - Build configuration with Kotlin DSL

## ✨ Features

✅ **Terminal-Style UI** - Cyan-colored monospace output  
✅ **Auto OAuth Flows** - Browsers open automatically for each service  
✅ **5 Cloud Services** - Vercel, Render, Supabase, Cloudflare, n8n  
✅ **Lightweight** - Minimal dependencies, fast startup  
✅ **Kotlin** - Modern Android development with coroutines  

## 🏗️ Architecture

### MainActivity
Manages the main app flow:
1. Shows terminal UI on launch
2. Logs "Initializing cloud setup"
3. Sequentially opens browsers for each service
4. Auto-scrolls terminal output
5. Displays completion message

### Manifest
Configures:
- Package: `com.orin.likha`
- GitHub icon as app icon
- Internet permissions
- OAuth callback intent filter

## 🛠️ Building

### Prerequisites
- Android Studio (Giraffe or newer)
- Android SDK 34
- Gradle 8.x
- Java 11+

### Build APK

```bash
./gradlew assembleRelease
```

Output: `app/build/outputs/apk/release/likha-v1.apk`

### Build from GitHub Actions

Nightly builds are automated:
- **Release Name**: `likha-v1.apk` (initial build)
- **Nightly Updates**: `likha-v1.0.0.1`, `likha-v1.0.0.2`, etc.
- **Trigger**: Daily at midnight UTC
- **Available Architectures**:
  - ARM64 (Raspberry Pi 4+, Apple Silicon)
  - ARM32 (Raspberry Pi 3, older ARM)
  - x86_64 (Intel/AMD devices)

## 📱 Installation

### On Android Device
1. Download `likha-v1.apk` from [releases](https://github.com/makagagahum/kodigo-ng-kawalan/releases)
2. Enable installation from unknown sources
3. Tap the APK to install
4. Launch the app
5. Grant internet permissions when prompted

### Custom Build
1. Clone the repo
2. Open `likha-android/` in Android Studio
3. Build → Generate Signed Bundle/APK
4. Follow the signing wizard
5. Install on device or emulator

## 🚀 How It Works

When you launch LIKHA:

```
🚀 LIKHA - Cloud Infrastructure Setup
📱 Likha sa Wala Edition

⏳ Initializing cloud setup...

🌐 Connecting to cloud platforms...
🔗 Opening Vercel authentication... → Browser opens
🔗 Opening Render authentication... → Browser opens
🔗 Opening Supabase console... → Browser opens
🔗 Opening Cloudflare dashboard... → Browser opens
🔗 Opening n8n automation... → Browser opens

✅ Setup complete!
💾 Configuration saved to .env

🎉 Your cloud infrastructure is ready!
```

## 🔐 Permissions

The app requests:
- `INTERNET` - For browser OAuth flows
- `ACCESS_NETWORK_STATE` - To check connectivity
- `READ/WRITE_EXTERNAL_STORAGE` - For .env file storage

## 👨‍💻 Development

### Key Coroutine Flow
```kotlin
private fun startCloudSetup() {
    mainScope.launch {
        // Sequential OAuth openings with delays
        for each service:
            logMessage("Opening...")
            delay(500)
            openOAuthBrowser(url)
            delay(2000)
    }
}
```

### Adding New Services
1. Add entry in `startCloudSetup()` function
2. Include in release notes
3. Update version number
4. Rebuild APK

## 📊 Version History

- **v1.0.0** - Initial release
- **Nightly builds** - Auto-increment with daily updates

## 🐛 Troubleshooting

**APK won't install**
- Check Android version (min SDK 21, Android 5.0)
- Verify "Unknown Sources" enabled
- Try different architecture variant

**Browsers not opening**
- Check internet connectivity
- Verify no VPN blocking issues
- Check logcat for errors

**App crashes on startup**
- Clear app cache
- Reinstall APK
- Check device has sufficient storage

## 📄 License

MIT - See parent repository LICENSE

## 👤 Author

**Marvin S. Villanueva**  
📧 marvin@orin.work  
🌐 marvin.orin.work  
🐙 github.com/makagagahum

---

**Made with 💙 for the community**  
*Likha sa Wala - Creation from Nothing*
