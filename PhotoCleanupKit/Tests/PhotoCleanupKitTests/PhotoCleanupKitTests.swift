import XCTest
@testable import PhotoCleanupKit

final class PhotoCleanupKitTests: XCTestCase {
    func testVersionIsSet() {
        XCTAssertFalse(PhotoCleanupKit.version.isEmpty)
    }
}
