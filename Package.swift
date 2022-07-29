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
                      url: "https://github.com/anotheren/OneLoginRebuild/releases/download/1.1.2/OneLoginSDK.xcframework.zip",
                      checksum: "ac8c8d9f4d8e5b241344f44aee184bb7569ae3705b5635af6c8a21ab78df46a3"),
        .binaryTarget(name: "TYRZUISDK",
                      url: "https://github.com/anotheren/OneLoginRebuild/releases/download/1.1.2/TYRZUISDK.xcframework.zip",
                      checksum: "982a155d22e0d58e8c4ab959057781955ebf7c8ae67c248ad57595a6b377d8f7"),
        .binaryTarget(name: "EAccountApiSDK",
                      url: "https://github.com/anotheren/OneLoginRebuild/releases/download/1.1.2/EAccountApiSDK.xcframework.zip",
                      checksum: "0de68bed194bc3b69a7d69f14e4593af5d0b7c571d90d49fa1d7ca74bcefdf52"),
        .binaryTarget(name: "account_login_sdk_noui_core",
                      url: "https://github.com/anotheren/OneLoginRebuild/releases/download/1.1.2/account_login_sdk_noui_core.xcframework.zip",
                      checksum: "104da2521f367b25b4a0b9c0dc8fb79ec71bc2d43f874e52787c8b10700fc015"),
    ]
)
