# OneLoginRebuild

## What's it?

* Rebuild `GTOneLoginSDK` to `OneLoginRebuild.xcframework`.
* Modules support and easy for Swift Package Manager to use.
* Support for ios-arm64/ios-arm64_x86_64-simulator.
* Require iOS 13+

## Change Log
| OneLoginRebuild | GTOneLoginSDK | Xcode |
| ----- | ----- | ----- |
| 1.0.0 | 2.7.5 | 13.4.1 (13F100) |

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/anotheren/OneLoginRebuild.git", from: "1.0.0")
]
```

### CocoaPods

```ruby
pod 'OneLoginRebuild'
```

## Manually Build

* Download the latest `GTOneLoginSDK` from ** [geetest.com](https://docs.geetest.com/onelogin/changelog/ios) **.
Or download Library/ from Release Page.
* unzip and move files to `Library/`
* run `create-xcframework.sh`

## Reference

* [xcframeworks](https://github.com/bielikb/xcframeworks)
* [arm64-to-sim](https://github.com/bogo/arm64-to-sim)
* [arm64-to-sim2](https://github.com/luosheng/arm64-to-sim)
