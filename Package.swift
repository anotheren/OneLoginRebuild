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
                    .linkedFramework("UIKit"),
                    .linkedFramework("Network"),
                    .linkedFramework("CFNetwork"),
                    .linkedFramework("Foundation"),
                    .linkedFramework("CoreTelephony"),
                    .linkedFramework("SystemConfiguration"),
                ]),
        .binaryTarget(name: "OneLoginRebuild",
                      url: "https://github.com/anotheren/OneLoginRebuild/releases/download/1.0.0/OneLoginRebuild.xcframework.zip",
                      checksum: "752fa3950238a6a8c7d361cb3e703de926c501dde241e50ff60112fa4b7d59ce"),
        .binaryTarget(name: "CMCC",
                      url: "https://github.com/anotheren/OneLoginRebuild/releases/download/1.0.0/CMCC.xcframework.zip",
                      checksum: "9a49515381c6e3f24e5e75d3294205fa217cf559266d73004943ac8ab5d23696"),
        .binaryTarget(name: "CTCC",
                      url: "https://github.com/anotheren/OneLoginRebuild/releases/download/1.0.0/CTCC.xcframework.zip",
                      checksum: "e0b96ca65970ef494ee49a591c377a207e4fd2bc3130a9cee7e785a0eba7f1c4"),
        .binaryTarget(name: "CUCC",
                      url: "https://github.com/anotheren/OneLoginRebuild/releases/download/1.0.0/CUCC.xcframework.zip",
                      checksum: "4811fd0c5b043cafd28b2ca47fe432880a5d19b9c645d50cc3059a22950c6ded"),
    ]
)
