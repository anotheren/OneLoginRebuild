// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OneLoginRebuild",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "OneLoginRebuild", targets: ["OneLoginRebuild"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "OneLoginRebuild",
                dependencies: [
                    "OneLoginSDK",
                    "TYRZUISDK",
                    "EAccountApiSDK",
                    "account_login_sdk_noui_core",
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
        .binaryTarget(name: "OneLoginSDK",
                      url: "https://github.com/anotheren/OneLoginRebuild/releases/download/1.1.0/OneLoginSDK.xcframework.zip",
                      checksum: "74f3a3ca9c612fba0b175273f22093ad9457cf6f5afbfefee05b2e5b59de7588"),
        .binaryTarget(name: "TYRZUISDK",
                      url: "https://github.com/anotheren/OneLoginRebuild/releases/download/1.1.0/TYRZUISDK.xcframework.zip",
                      checksum: "6d599e81ec8bf958863c4c534d9e2f1dbd9a606e2cafbcecef41437ff1866577"),
        .binaryTarget(name: "EAccountApiSDK",
                      url: "https://github.com/anotheren/OneLoginRebuild/releases/download/1.1.0/EAccountApiSDK.xcframework.zip",
                      checksum: "bcefea6ed8d4a73937b8e2c460b1a67315f7d49c12b996875f26372f92a898e8"),
        .binaryTarget(name: "account_login_sdk_noui_core",
                      url: "https://github.com/anotheren/OneLoginRebuild/releases/download/1.1.0/account_login_sdk_noui_core.xcframework.zip",
                      checksum: "6087c289e5ff186098ae0b26a05ee11e7284a1407d9daa8317d0ee84cd0c3f0e"),
    ]
)
