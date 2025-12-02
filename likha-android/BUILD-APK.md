# 📱 Building LIKHA APK

## Step 1: Prerequisites

Before building the LIKHA APK, ensure you have:

### Windows
- [ ] Android Studio (Giraffe or newer) [Download](https://developer.android.com/studio)
- [ ] Android SDK 34 (installed via Android Studio SDK Manager)
- [ ] Gradle 8.x (bundled with Android Studio)
- [ ] Java 11+ JDK
- [ ] Git

### macOS
```bash
brew install android-studio git
```

### Linux
```bash
# Ubuntu/Debian
sudo apt-get install android-studio git openjdk-11-jdk

# Fedora
sudo dnf install android-studio git java-11-openjdk
```

---

## Step 2: Clone Repository

```bash
git clone https://github.com/makagagahum/kodigo-ng-kawalan.git
cd kodigo-ng-kawalan/likha-android
```

---

## Step 3: Build APK using Gradle

### Option A: Debug Build (for testing)

```bash
# On Windows
.\\gradlew.bat assembleDebug

# On macOS / Linux
./gradlew assembleDebug
```

**Output**: `app/build/outputs/apk/debug/app-debug.apk`

### Option B: Release Build (for distribution)

```bash
# On Windows
.\\gradlew.bat assembleRelease

# On macOS / Linux
./gradlew assembleRelease
```

**Output**: `app/build/outputs/apk/release/likha-v1.apk`

---

## Step 4: Signing the APK (Release Only)

For the release APK, you need to sign it with your own keystore:

### Create Keystore (first time only)

```bash
keytool -genkey -v -keystore likha.keystore -keyalg RSA -keysize 2048 -validity 10000 -alias likha-key
```

This will prompt you for:
- Keystore password (save this!)
- Key password (usually same as keystore)
- Your details (name, organization, etc.)

### Sign the APK

```bash
jarsigner -verbose -sigalg SHA256withRSA -digestalg SHA-256 \\
  -keystore likha.keystore \\
  app/build/outputs/apk/release/app-release-unsigned.apk \\
  likha-key
```

### Align and Finalize

```bash
zipalign -v 4 \\
  app/build/outputs/apk/release/app-release-unsigned.apk \\
  likha-v1.apk
```

**Final Output**: `likha-v1.apk` (ready for distribution)

---

## Step 5: Install on Device

### Via USB (Debug)

```bash
adb install app/build/outputs/apk/debug/app-debug.apk
```

### Via Emulator

1. Open Android Studio
2. Click "Run" (Shift+F10)
3. Select emulator
4. App launches automatically

### Manual Installation

1. Transfer `likha-v1.apk` to Android device
2. Open file manager
3. Tap APK file
4. Tap "Install"
5. Grant permissions when prompted

---

## Step 6: Verify Installation

On your Android device:

1. Look for **LIKHA** app icon (GitHub logo)
2. Tap to open
3. Verify terminal UI shows with cyan text
4. Browsers should open automatically for OAuth

---

## GitHub Actions (Automated Builds)

The repository includes GitHub Actions workflow for automated nightly builds:

**Workflow File**: `.github/workflows/build-releases.yml`

### How It Works

1. Triggers daily at **midnight UTC**
2. Builds for multiple architectures:
   - `likha-v1-x86_64.apk` (Intel/AMD)
   - `likha-v1-arm64.apk` (Apple Silicon, Graviton, Pi 4+)
   - `likha-v1-arm32.apk` (Pi 3, older ARM)
3. Creates GitHub Release automatically
4. Uploads APK as asset
5. Version auto-increments to `likha-v1.0.0.1`, `likha-v1.0.0.2`, etc.

### Manual Trigger

```bash
gh workflow run build-releases.yml
```

---

## Troubleshooting

### "SDK not found"

```bash
# Point to Android SDK
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
```

### "Gradle build failed"

```bash
# Clean and rebuild
./gradlew clean build
```

### "adb: command not found"

```bash
export PATH=$PATH:$ANDROID_HOME/platform-tools
```

### APK too large

- Enable ProGuard minification in `build.gradle.kts`
- Split APK by architecture

---

## File Structure

```
likha-android/
├── AndroidManifest.xml     # App manifest
├── MainActivity.kt         # Main activity (Kotlin)
├── build.gradle.kts        # Build configuration
├── README.md               # Main documentation
├── BUILD-APK.md            # This file
├── app/
├── gradle/
├── gradlew                 # Gradle wrapper script
├── gradlew.bat             # Gradle wrapper batch
└── settings.gradle.kts     # Gradle settings
```

---

## Release Checklist

Before releasing likha-v1.apk:

- [ ] Test on multiple Android versions (API 21+)
- [ ] Test on multiple architectures (ARM64, ARM32, x86_64)
- [ ] Verify all 5 OAuth flows work (Vercel, Render, Supabase, Cloudflare, n8n)
- [ ] Check APK size is reasonable (<50MB)
- [ ] Sign APK with release keystore
- [ ] Test installation from GitHub Releases
- [ ] Update version in `build.gradle.kts`
- [ ] Create GitHub Release with changelog
- [ ] Announce in project README

---

## Author

**Marvin S. Villanueva**  
📧 marvin@orin.work  
🌐 marvin.orin.work  
🐙 github.com/makagagahum

---

**Made with 💙 for the community**  
*Likha sa Wala - Creation from Nothing*
