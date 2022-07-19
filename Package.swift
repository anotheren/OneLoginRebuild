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
                dependencies: ["OneLoginRebuild"],
                linkerSettings: [
                    .linkedLibrary("z"),
                    .linkedLibrary("c++"),
                    .linkedFramework("UIKit"),
                    .linkedFramework("Network"),
                    .linkedFramework("CFNetwork"),
                    .linkedFramework("Foundation"),
                    .linkedFramework("CoreTelephony"),
                    .linkedFramework("SystemConfiguration"),
                ]),
        .binaryTarget(name: "OneLoginRebuild",
                      url: "https://github.com/anotheren/OneLoginRebuild/releases/download/1.0.0/OneLoginRebuild.xcframework.zip",
                      checksum: "47b5b74f3ffea699e08415f4a4108ea23caae1a1b3c7eae153eaf4389ae89693"),
    ]
)
