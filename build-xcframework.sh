#!/bin/bash

green=`tput setaf 2`
reset=`tput sgr0`
source_version=2.7.5

echo "${green}[1/10] Download Files${reset}"
if [ -d "Build/" ]; then
    rm -rf "Build/"
fi
if [ -d "Library/" ]; then
    rm -rf "Library/"
fi
if [ -d "Downloads/" ]; then
    rm -rf "Downloads/"
fi

mkdir -p Downloads/
curl -LJ -o Downloads/OneLoginSDK.zip https://github.com/GeeTeam/onelogin-ios-cocoapods-support/archive/refs/tags/${source_version}.zip
unzip -q Downloads/OneLoginSDK.zip "onelogin-ios-cocoapods-support-${source_version}/SDK/*" -d Downloads/
mv Downloads/onelogin-ios-cocoapods-support-${source_version}/SDK/* Downloads/

echo "${green}[2/10] Prepare OneLoginRebuild${reset}"
mkdir -p Build/OneLoginSDK
mkdir -p Library/OneLoginRebuild

lipo -thin arm64 Downloads/OneLoginSDK.framework/OneLoginSDK -output Library/OneLoginRebuild/OneLoginSDK.arm64
lipo -thin arm64 Downloads/OneLoginSDK.framework/OneLoginSDK -output Build/OneLoginSDK/OneLoginSDK.patch.arm64
lipo -thin x86_64 Downloads/OneLoginSDK.framework/OneLoginSDK -output Build/OneLoginSDK/OneLoginSDK.x86_64
./arm64-to-sim Build/OneLoginSDK/OneLoginSDK.patch.arm64
lipo -create Build/OneLoginSDK/OneLoginSDK.patch.arm64 Build/OneLoginSDK/OneLoginSDK.x86_64 -output Library/OneLoginRebuild/OneLoginSDK.arm64-x86_64.sim
cp -r Downloads/OneLoginSDK.framework/Headers/ Library/OneLoginRebuild/Headers/
cp -r Downloads/OneLoginResource.bundle Library/OneLoginRebuild/OneLoginResource.bundle

echo "${green}[3/10] Prepare CMCC${reset}"
mkdir -p Build/TYRZUISDK
mkdir -p Library/CMCC

lipo -thin arm64 Downloads/TYRZUISDK.framework/TYRZUISDK -output Library/CMCC/TYRZUISDK.arm64
cp Downloads/TYRZUISDK.framework/TYRZUISDK Build/TYRZUISDK/TYRZUISDK
./arm64-to-sim2 patch Build/TYRZUISDK/TYRZUISDK
lipo -thin arm64 Build/TYRZUISDK/TYRZUISDK -output Build/TYRZUISDK/TYRZUISDK.patch.arm64
lipo -thin x86_64 Build/TYRZUISDK/TYRZUISDK -output Build/TYRZUISDK/TYRZUISDK.x86_64
lipo -create Build/TYRZUISDK/TYRZUISDK.patch.arm64 Build/TYRZUISDK/TYRZUISDK.x86_64 -output Library/CMCC/TYRZUISDK.arm64-x86_64.sim
cp -r Downloads/TYRZUISDK.framework/Headers/ Library/CMCC/Headers/

echo "${green}[4/10] Prepare CTCC${reset}"
mkdir -p Build/EAccountApiSDK
mkdir -p Library/CTCC

lipo -thin arm64 Downloads/EAccountApiSDK.framework/EAccountApiSDK -output Library/CTCC/EAccountApiSDK.arm64
cp Downloads/EAccountApiSDK.framework/EAccountApiSDK Build/EAccountApiSDK/EAccountApiSDK
./arm64-to-sim2 patch Build/EAccountApiSDK/EAccountApiSDK
lipo -thin arm64 Build/EAccountApiSDK/EAccountApiSDK -output Build/EAccountApiSDK/EAccountApiSDK.patch.arm64
lipo -thin x86_64 Build/EAccountApiSDK/EAccountApiSDK -output Build/EAccountApiSDK/EAccountApiSDK.x86_64
lipo -create Build/EAccountApiSDK/EAccountApiSDK.patch.arm64 Build/EAccountApiSDK/EAccountApiSDK.x86_64 -output Library/CTCC/EAccountApiSDK.arm64-x86_64.sim
cp -r Downloads/EAccountApiSDK.framework/Headers/ Library/CTCC/Headers/

echo "${green}[5/10] Prepare CUCC${reset}"
mkdir -p Build/account_login_sdk_noui_core
mkdir -p Library/CUCC

lipo -thin arm64 Downloads/account_login_sdk_noui_core.framework/account_login_sdk_noui_core -output Library/CUCC/account_login_sdk_noui_core.arm64
cp Downloads/account_login_sdk_noui_core.framework/account_login_sdk_noui_core Build/account_login_sdk_noui_core/account_login_sdk_noui_core
./arm64-to-sim2 patch Build/account_login_sdk_noui_core/account_login_sdk_noui_core
lipo -thin arm64 Build/account_login_sdk_noui_core/account_login_sdk_noui_core -output Build/account_login_sdk_noui_core/account_login_sdk_noui_core.patch.arm64
lipo -thin x86_64 Build/account_login_sdk_noui_core/account_login_sdk_noui_core -output Build/account_login_sdk_noui_core/account_login_sdk_noui_core.x86_64
lipo -create Build/account_login_sdk_noui_core/account_login_sdk_noui_core.patch.arm64 Build/account_login_sdk_noui_core/account_login_sdk_noui_core.x86_64 -output Library/CUCC/account_login_sdk_noui_core.arm64-x86_64.sim
cp -r Downloads/account_login_sdk_noui_core.framework/Headers/ Library/CUCC/Headers/

echo "${green}[6/10] Build OneLoginRebuild${reset}"
echo "${green}[S1/4] Build platform=iOS${reset}"
xcodebuild archive \
-project OneLoginRebuild.xcodeproj \
-scheme OneLoginRebuild \
-destination "generic/platform=iOS" \
-archivePath "Build/OneLoginRebuild/iphoneos" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
-quiet
echo "${green}[S2/4] Build platform=iOS Simulator${reset}"
xcodebuild archive \
-project OneLoginRebuild.xcodeproj \
-scheme OneLoginRebuild-sim \
-destination "generic/platform=iOS Simulator" \
-archivePath "Build/OneLoginRebuild/iphonesimulator" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
-quiet
echo "${green}[S3/4] Create xcframework${reset}"
xcodebuild -create-xcframework \
-framework "Build/OneLoginRebuild/iphoneos.xcarchive/Products/Library/Frameworks/OneLoginRebuild.framework" \
-framework "Build/OneLoginRebuild/iphonesimulator.xcarchive/Products/Library/Frameworks/OneLoginRebuild.framework" \
-output "Build/OneLoginRebuild.xcframework"
echo "${green}[S4/4] Create Zip & Compute Checksum${reset}"
zip -r OneLoginRebuild.xcframework.zip Build/OneLoginRebuild.xcframework -q
swift package compute-checksum OneLoginRebuild.xcframework.zip

echo "${green}[7/10] Build CMCC${reset}"
echo "${green}[S1/4] Build platform=iOS${reset}"
xcodebuild archive \
-project OneLoginRebuild.xcodeproj \
-scheme CMCC \
-destination "generic/platform=iOS" \
-archivePath "Build/CMCC/iphoneos" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
-quiet
echo "${green}[S2/4] Build platform=iOS Simulator${reset}"
xcodebuild archive \
-project OneLoginRebuild.xcodeproj \
-scheme CMCC-sim \
-destination "generic/platform=iOS Simulator" \
-archivePath "Build/CMCC/iphonesimulator" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
-quiet
echo "${green}[S3/4] Create xcframework${reset}"
xcodebuild -create-xcframework \
-framework "Build/CMCC/iphoneos.xcarchive/Products/Library/Frameworks/CMCC.framework" \
-framework "Build/CMCC/iphonesimulator.xcarchive/Products/Library/Frameworks/CMCC.framework" \
-output "Build/CMCC.xcframework"
echo "${green}[S4/4] Create Zip & Compute Checksum${reset}"
zip -r CMCC.xcframework.zip Build/CMCC.xcframework -q
swift package compute-checksum CMCC.xcframework.zip

echo "${green}[8/10] Build CTCC${reset}"
echo "${green}[S1/4] Build platform=iOS${reset}"
xcodebuild archive \
-project OneLoginRebuild.xcodeproj \
-scheme CTCC \
-destination "generic/platform=iOS" \
-archivePath "Build/CTCC/iphoneos" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
-quiet
echo "${green}[S2/4] Build platform=iOS Simulator${reset}"
xcodebuild archive \
-project OneLoginRebuild.xcodeproj \
-scheme CTCC-sim \
-destination "generic/platform=iOS Simulator" \
-archivePath "Build/CTCC/iphonesimulator" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
-quiet
echo "${green}[S3/4] Create xcframework${reset}"
xcodebuild -create-xcframework \
-framework "Build/CTCC/iphoneos.xcarchive/Products/Library/Frameworks/CTCC.framework" \
-framework "Build/CTCC/iphonesimulator.xcarchive/Products/Library/Frameworks/CTCC.framework" \
-output "Build/CTCC.xcframework"
echo "${green}[S4/4] Create Zip & Compute Checksum${reset}"
zip -r CTCC.xcframework.zip Build/CTCC.xcframework -q
swift package compute-checksum CTCC.xcframework.zip

echo "${green}[9/10] Build CUCC${reset}"
echo "${green}[S1/4] Build platform=iOS${reset}"
xcodebuild archive \
-project OneLoginRebuild.xcodeproj \
-scheme CUCC \
-destination "generic/platform=iOS" \
-archivePath "Build/CUCC/iphoneos" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
-quiet
echo "${green}[S2/4] Build platform=iOS Simulator${reset}"
xcodebuild archive \
-project OneLoginRebuild.xcodeproj \
-scheme CUCC-sim \
-destination "generic/platform=iOS Simulator" \
-archivePath "Build/CUCC/iphonesimulator" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
-quiet
echo "${green}[S3/4] Create xcframework${reset}"
xcodebuild -create-xcframework \
-framework "Build/CUCC/iphoneos.xcarchive/Products/Library/Frameworks/CUCC.framework" \
-framework "Build/CUCC/iphonesimulator.xcarchive/Products/Library/Frameworks/CUCC.framework" \
-output "Build/CUCC.xcframework"
echo "${green}[S4/4] Create Zip & Compute Checksum${reset}"
zip -r CUCC.xcframework.zip Build/CUCC.xcframework -q
swift package compute-checksum CUCC.xcframework.zip