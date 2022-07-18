// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OneLoginRebuild",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "OneLoginRebuild", targets: ["OneLoginRebuildLink"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "OneLoginRebuildLink",
                dependencies: ["OneLoginRebuild"]),
        .binaryTarget(name: "OneLoginRebuild",
                      path: "Build/OneLoginRebuild.xcframework")
    ]
)
