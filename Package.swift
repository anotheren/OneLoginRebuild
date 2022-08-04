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
                dependencies: [
                    "OneLoginRebuild",
                    "CMCC",
                    "CTCC",
                    "CUCC",
                ],
                linkerSettings: [
                    .linkedLibrary("z"),
                    .linkedLibrary("c++"),
                    .linkedLibrary("sqlite3"),
                    .linkedFramework("UIKit"),
                    .linkedFramework("Network"),
                    .linkedFramework("CFNetwork"),
                    .linkedFramework("Foundation"),
                    .linkedFramework("CoreTelephony"),
                    .linkedFramework("SystemConfiguration"),
                ]),
        .binaryTarget(name: "OneLoginRebuild",
                      url: "https://github.com/anotheren/OneLoginRebuild/releases/download/1.2.0/OneLoginRebuild.xcframework.zip",
                      checksum: "e2fd186383cb0ea2c5b199060f3912f3251727b18305fcc328a0885765a3f511"),
        .binaryTarget(name: "CMCC",
                      url: "https://github.com/anotheren/OneLoginRebuild/releases/download/1.2.0/CMCC.xcframework.zip",
                      checksum: "96b5f220b54b27184980e9beada654799542953dfdbb7431bf9d6010fd74dfcf"),
        .binaryTarget(name: "CTCC",
                      url: "https://github.com/anotheren/OneLoginRebuild/releases/download/1.2.0/CTCC.xcframework.zip",
                      checksum: "ba828bf15657e7486b225dc33b79e7c6f3ee06083d9519f69a68ef96a537c693"),
        .binaryTarget(name: "CUCC",
                      url: "https://github.com/anotheren/OneLoginRebuild/releases/download/1.2.0/CUCC.xcframework.zip",
                      checksum: "780c8cb36357cd7bf0ac8e291ff5447a36e02ad55782c26975fd9b4c7115ad2e"),
    ]
)
