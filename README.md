# PhotoCleanup

A personal, on-device iPhone app that scans your Photos library to find duplicates,
blurry/low-quality photos, suggested albums (trips, family, holidays), and lets you
build custom pattern albums (e.g. "Home Reno") from a handful of example photos.

Everything runs on-device — no backend, no photos ever leave your phone.

This is milestone **M0: project scaffold**. There's no scanning functionality yet —
just a running app shell, ready for the next milestones to build on.

## Getting the app onto your iPhone (no Mac required)

Building an iOS app requires Apple's Xcode toolchain, which only runs on macOS — that's
an Apple restriction, not a choice made here. Since this project is developed from
Windows, the build itself happens in the cloud (via GitHub Actions, using a free
macOS runner), and you install the result onto your iPhone using a Windows sideloading
tool with your own (free) Apple ID. No Mac purchase or rental needed.

### 1. Get a built `.ipa` from GitHub Actions

Every push to this branch triggers a cloud build (see `.github/workflows/build.yml`).
To get the file:

1. Go to this repository on GitHub → **Actions** tab → open the latest **Build unsigned
   IPA** run (or click **Run workflow** to trigger one manually).
2. Once it finishes (a few minutes), scroll to **Artifacts** and download
   `PhotoCleanupApp-unsigned-ipa` — this is a `.zip` containing `PhotoCleanupApp.ipa`.

This `.ipa` is intentionally **unsigned** — the sideloading tool below does the signing
locally using your Apple ID, so no Apple credentials ever need to be stored in CI.

### 2. Install it on your iPhone with Sideloadly

1. On your Windows PC, install [iTunes from Apple's website](https://www.apple.com/itunes/)
   (not the Microsoft Store version) — this provides the drivers Windows needs to talk
   to an iPhone over USB.
2. Download and install [Sideloadly](https://sideloadly.io/).
3. Connect your iPhone to your PC via USB cable and trust the computer when prompted
   on your phone.
4. Open Sideloadly, drag `PhotoCleanupApp.ipa` into it, enter your Apple ID (a free,
   regular Apple ID — no paid Developer account needed) when prompted, and click
   **Start**.
5. On your iPhone, go to **Settings → General → VPN & Device Management**, and trust
   the developer certificate under your Apple ID before opening the app.

**Note:** with a free Apple ID, this kind of install expires after **7 days** — after
that, just repeat step 4 with the same (or a freshly downloaded) `.ipa` to reinstall.
[AltStore](https://altstore.io/) is a similar alternative if you'd prefer an on-device
app for managing/refreshing installs instead of repeating this each time.

You should see a "PhotoCleanup" home screen with a disabled "Scan Library" button —
that's expected for this milestone.

## If you ever do use a Mac

The project also works the traditional way if you (or a future collaborator) have
access to a Mac:

1. Install [Homebrew](https://brew.sh), then `brew install xcodegen`.
2. From the repo root, run `xcodegen generate` to create `PhotoCleanup.xcodeproj`.
3. Open it in Xcode, sign with your Apple ID under *Signing & Capabilities*, connect
   your iPhone, and press Run.

## Project structure

- `PhotoCleanupApp/` — the SwiftUI app target (Views, ViewModels, Services).
- `PhotoCleanupKit/` — a local Swift package with framework-free, pure-Swift logic
  (clustering, scoring algorithms). Testable directly via `swift test`, with no
  simulator, device, or real photo library needed (on a Mac) — or via the
  `PhotoCleanupKitTests` job in CI otherwise.
- `project.yml` — XcodeGen spec that generates `PhotoCleanup.xcodeproj`.
- `.github/workflows/build.yml` — builds an unsigned, installable `.ipa` in the cloud
  on every push.

## Roadmap

See the project plan for the full milestone breakdown (M1: library permission +
listing, M2: blur/quality detection + swipe review, M3: duplicate detection, M4:
categorized albums, M5: custom pattern albums, M6: orchestration polish).
