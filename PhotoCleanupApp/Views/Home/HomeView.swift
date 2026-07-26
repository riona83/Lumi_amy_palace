import Photos
import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("PhotoCleanup")
                .task {
                    await viewModel.onAppear()
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.accessStatus {
        case .notDetermined:
            ProgressView("Requesting access…")
        case .denied:
            deniedView
        case .authorized, .limited:
            libraryView
        }
    }

    private var deniedView: some View {
        VStack(spacing: Theme.Spacing.md) {
            Spacer()
            Image(systemName: "lock.shield")
                .font(.system(size: 48))
                .foregroundStyle(.secondary)
            Text("Photo Access Needed")
                .font(.title2.bold())
            Text("PhotoCleanup needs permission to read your photo library to find duplicates, blurry photos, and suggested albums.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Theme.Spacing.xl)
            Button("Open Settings") {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            .buttonStyle(.borderedProminent)
            Spacer()
        }
        .padding()
    }

    private var libraryView: some View {
        VStack(spacing: 0) {
            if viewModel.accessStatus == .limited {
                limitedBanner
            }

            HStack {
                Text("\(viewModel.photoCount) photos")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding(.horizontal, Theme.Spacing.md)
            .padding(.top, Theme.Spacing.sm)

            if viewModel.assets.isEmpty {
                emptyLibraryView
            } else {
                PhotoGridView(items: viewModel.assets) { asset in
                    PhotoThumbnailCell(asset: asset, loadThumbnail: viewModel.thumbnail)
                }
            }

            Button {
                // Scanning arrives in a later milestone.
            } label: {
                Label("Scan Library", systemImage: "sparkle.magnifyingglass")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .disabled(true)
            .padding(Theme.Spacing.md)
        }
    }

    private var emptyLibraryView: some View {
        VStack(spacing: Theme.Spacing.sm) {
            Spacer()
            Image(systemName: "photo.on.rectangle.angled")
                .font(.system(size: 40))
                .foregroundStyle(.secondary)
            Text("No photos found in your library.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Spacer()
        }
    }

    private var limitedBanner: some View {
        HStack {
            Image(systemName: "photo.badge.exclamationmark")
            Text("Limited access — only some photos are visible.")
                .font(.footnote)
            Spacer()
            Button("Choose More") {
                viewModel.presentLimitedLibraryPicker()
            }
            .font(.footnote.bold())
        }
        .padding(Theme.Spacing.sm)
        .background(Color.yellow.opacity(0.15))
    }
}

#Preview {
    HomeView()
}
