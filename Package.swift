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
                      url: "https://github.com/anotheren/OneLoginRebuild/releases/download/1.2.1/OneLoginRebuild.xcframework.zip",
                      checksum: "d955f9ad80efb4db6b8bfd9d512d5e3df4787f063033d60917aa212ce39a5e49"),
        .binaryTarget(name: "CMCC",
                      url: "https://github.com/anotheren/OneLoginRebuild/releases/download/1.2.1/CMCC.xcframework.zip",
                      checksum: "c2bfbf95849a47e4620e7979deb51b304384f6f95c3cc5e3cf0fd56b7f7be434"),
        .binaryTarget(name: "CTCC",
                      url: "https://github.com/anotheren/OneLoginRebuild/releases/download/1.2.1/CTCC.xcframework.zip",
                      checksum: "79e0e0e2feea71c7e54db0dcb2871b07c3d3e2fd838ad83d2b3641840c75e75f"),
        .binaryTarget(name: "CUCC",
                      url: "https://github.com/anotheren/OneLoginRebuild/releases/download/1.2.1/CUCC.xcframework.zip",
                      checksum: "c4c2b74b6e287504b8d7b0f8224aeda3df93b2ff6788668e3cafe79adbd97657"),
    ]
)
