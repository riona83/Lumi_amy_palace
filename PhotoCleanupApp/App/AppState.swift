import Foundation

/// Top-level, app-wide state. Scan results and progress will be added here
/// in later milestones as `ScanCoordinator` and the result view models land.
@Observable
final class AppState {
    var hasCompletedFirstScan = false
}
