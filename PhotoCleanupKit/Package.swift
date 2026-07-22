// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PhotoCleanupKit",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(name: "PhotoCleanupKit", targets: ["PhotoCleanupKit"])
    ],
    targets: [
        .target(name: "PhotoCleanupKit"),
        .testTarget(name: "PhotoCleanupKitTests", dependencies: ["PhotoCleanupKit"])
    ]
)
