/// Pure, framework-free algorithms shared by the PhotoCleanup app.
///
/// This package deliberately avoids importing UIKit, PhotoKit, or Vision so its
/// logic (duplicate clustering, blur scoring, event clustering, pattern matching)
/// can be unit-tested with `swift test` on a plain Mac terminal — no simulator,
/// device, or real photo library required. The app target wraps this logic with
/// real PhotoKit/Vision calls.
public enum PhotoCleanupKit {
    public static let version = "0.1.0"
}
