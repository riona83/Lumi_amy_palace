import SwiftUI

/// Shared visual constants so every screen stays consistent by reusing these
/// values instead of hand-picking spacing/radii per view.
enum Theme {
    enum Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
    }

    enum Radius {
        static let card: CGFloat = 16
        static let control: CGFloat = 12
    }

    enum GridLayout {
        static let thumbnailMinSize: CGFloat = 110
        static let thumbnailSpacing: CGFloat = 4
    }
}
