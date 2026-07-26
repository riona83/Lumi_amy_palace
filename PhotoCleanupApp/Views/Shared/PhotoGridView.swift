import SwiftUI

/// Shared card-grid layout reused by every photo collection screen
/// (library, duplicates, low-quality, categories, custom-album matches)
/// so they all stay visually consistent.
struct PhotoGridView<Item: Identifiable, Cell: View>: View {
    let items: [Item]
    @ViewBuilder let cell: (Item) -> Cell

    private let columns = [
        GridItem(.adaptive(minimum: Theme.GridLayout.thumbnailMinSize), spacing: Theme.GridLayout.thumbnailSpacing)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: Theme.GridLayout.thumbnailSpacing) {
                ForEach(items) { item in
                    cell(item)
                        .aspectRatio(1, contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: Theme.Radius.control))
                }
            }
            .padding(Theme.Spacing.sm)
        }
    }
}
