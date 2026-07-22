# PhotoCleanup

A personal, on-device iPhone app that scans your Photos library to find duplicates,
blurry/low-quality photos, suggested albums (trips, family, holidays), and lets you
build custom pattern albums (e.g. "Home Reno") from a handful of example photos.

Everything runs on-device — no backend, no photos ever leave your phone.

This is milestone **M0: project scaffold**. There's no scanning functionality yet —
just a running app shell, ready for the next milestones to build on.

## One-time setup (you'll need a Mac with Xcode)

This project's Xcode project file is *generated*, not committed — that keeps the repo
clean and avoids Xcode project-file merge conflicts. You generate it locally with
[XcodeGen](https://github.com/yonaskolb/XcodeGen), reading the spec in `project.yml`.

1. **Install Xcode** from the Mac App Store, if you don't already have it. Open it once
   so it finishes installing its command-line tools.
2. **Install Homebrew** (if you don't have it): follow the instructions at
   [brew.sh](https://brew.sh).
3. **Install XcodeGen**:
   ```
   brew install xcodegen
   ```
4. **Clone this repo** (or pull the latest changes) and, from the repo's root folder,
   run:
   ```
   xcodegen generate
   ```
   This creates `PhotoCleanup.xcodeproj`. You'll re-run this command any time
   `project.yml` changes (I'll tell you when that happens).
5. **Open `PhotoCleanup.xcodeproj`** in Xcode.
6. **Sign the app with your free Apple ID**: select the `PhotoCleanupApp` target →
   *Signing & Capabilities* tab → under *Team*, choose your personal team (sign in
   with your Apple ID in Xcode's Settings → Accounts first, if you haven't). If Xcode
   complains the bundle identifier `com.riona.photocleanup` is already taken, change
   it to something like `com.riona.photocleanup.yourname`.
7. **Connect your iPhone** via cable (or set up wireless debugging), trust the
   computer on your phone if prompted, and select your iPhone as the run destination
   in Xcode's toolbar (instead of a simulator).
8. **Press Run (▶)**. On first install, your iPhone will refuse to open the app until
   you go to **Settings → General → VPN & Device Management** and trust the developer
   certificate.
9. You should see a "PhotoCleanup" home screen with a disabled "Scan Library" button —
   that's expected for this milestone.

**Note:** with a free (non-paid) Apple ID, the app's provisioning expires after 7
days — just re-run it from Xcode to refresh it. No paid Apple Developer account is
needed for personal use like this.

## Project structure

- `PhotoCleanupApp/` — the SwiftUI app target (Views, ViewModels, Services).
- `PhotoCleanupKit/` — a local Swift package with framework-free, pure-Swift logic
  (clustering, scoring algorithms). Testable directly via `swift test` in this folder,
  with no simulator, device, or real photo library needed.
- `project.yml` — XcodeGen spec that generates `PhotoCleanup.xcodeproj`.

## Running the Kit's tests

From the `PhotoCleanupKit/` folder, on your Mac:

```
cd PhotoCleanupKit
swift test
```

## Roadmap

See the project plan for the full milestone breakdown (M1: library permission +
listing, M2: blur/quality detection + swipe review, M3: duplicate detection, M4:
categorized albums, M5: custom pattern albums, M6: orchestration polish).
