import SwiftUI

struct HomeView: View {
    @Environment(AppState.self) private var appState

    var body: some View {
        NavigationStack {
            VStack(spacing: Theme.Spacing.lg) {
                Spacer()

                Image(systemName: "photo.stack")
                    .font(.system(size: 56))
                    .foregroundStyle(.tint)

                VStack(spacing: Theme.Spacing.sm) {
                    Text("PhotoCleanup")
                        .font(.largeTitle.bold())
                    Text("Find duplicates, blurry shots, and suggested albums — all on your device.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, Theme.Spacing.xl)
                }

                Spacer()

                VStack(spacing: Theme.Spacing.sm) {
                    Button {
                        // Scanning arrives in a later milestone.
                    } label: {
                        Label("Scan Library", systemImage: "sparkle.magnifyingglass")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .disabled(true)

                    Text("Scanning isn't built yet — this is the project scaffold.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, Theme.Spacing.lg)
                .padding(.bottom, Theme.Spacing.lg)
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    HomeView()
        .environment(AppState())
}
