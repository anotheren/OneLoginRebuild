#!/bin/bash

FRAMEWORK_NAME="OneLoginRebuild"
LIBRARY_NAME="OneLogin/OneLoginSDK"
CMCC_LIBRARY_NAME="CMCC/TYRZUISDK"
CUCC_LIBRARY_NAME="CUCC/account_login_sdk_noui_core"
CTCC_LIBRARY_NAME="CTCC/EAccountApiSDK"

echo "[1/7] Remove last build"
if [ -d "Build/" ]; then
    rm -rf "Build/"
fi
if [ -f "${FRAMEWORK_NAME}.xcframework.zip" ]; then
    rm -rf "${FRAMEWORK_NAME}.xcframework.zip"
fi

echo "[2/7] Prepare Patch"
#OneLogin
lipo -thin arm64 Library/${LIBRARY_NAME} -output Library/${LIBRARY_NAME}.ios-arm64
lipo -thin arm64 Library/${LIBRARY_NAME} -output Library/${LIBRARY_NAME}.ios-arm64-simulator
./arm64-to-sim Library/${LIBRARY_NAME}.ios-arm64-simulator 13
lipo -thin x86_64 Library/${LIBRARY_NAME} -output Library/${LIBRARY_NAME}.x86_64-simulator
lipo -create -output \
    Library/${LIBRARY_NAME}.ios-arm64_x86_64-simulator \
    Library/${LIBRARY_NAME}.x86_64-simulator \
    Library/${LIBRARY_NAME}.ios-arm64-simulator
rm -rf Library/${LIBRARY_NAME}.ios-arm64-simulator
rm -rf Library/${LIBRARY_NAME}.x86_64-simulator
mv Library/${LIBRARY_NAME} Library/${LIBRARY_NAME}.original

echo "[3/7] Xcode Build Archive for generic/platform=iOS"
mv Library/${LIBRARY_NAME}.ios-arm64 Library/${LIBRARY_NAME}

xcodebuild archive \
-project ${FRAMEWORK_NAME}.xcodeproj \
-scheme ${FRAMEWORK_NAME} \
-destination "generic/platform=iOS" \
-archivePath "Build/iphoneos" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
-quiet

mv Library/${LIBRARY_NAME} Library/${LIBRARY_NAME}.ios-arm64

echo "[4/7] Xcode Build Archive for generic/platform=iOS Simulator"
mv Library/${LIBRARY_NAME}.ios-arm64_x86_64-simulator Library/${LIBRARY_NAME}
./arm64-to-sim2 patch Library/${CMCC_LIBRARY_NAME}
./arm64-to-sim2 patch Library/${CTCC_LIBRARY_NAME}
./arm64-to-sim2 patch Library/${CUCC_LIBRARY_NAME}

xcodebuild archive \
-project ${FRAMEWORK_NAME}.xcodeproj \
-scheme ${FRAMEWORK_NAME} \
-destination "generic/platform=iOS Simulator" \
-archivePath "Build/iphonesimulator" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
-quiet

mv Library/${LIBRARY_NAME} Library/${LIBRARY_NAME}.ios-arm64_x86_64-simulator

echo "[5/7] Create xcframework"
xcodebuild -create-xcframework \
-framework "Build/iphoneos.xcarchive/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework" \
-framework "Build/iphonesimulator.xcarchive/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework" \
-output "Build/${FRAMEWORK_NAME}.xcframework"

echo "[6/7] Create Zip & Compute Checksum"
zip -r ${FRAMEWORK_NAME}.xcframework.zip Build/${FRAMEWORK_NAME}.xcframework -q
swift package compute-checksum ${FRAMEWORK_NAME}.xcframework.zip

echo "[7/7] Clean"
rm -rf Library/${LIBRARY_NAME}.ios-arm64_x86_64-simulator
rm -rf Library/${LIBRARY_NAME}.ios-arm64
mv Library/${LIBRARY_NAME}.original Library/${LIBRARY_NAME}

./arm64-to-sim2 restore "Library/${CMCC_LIBRARY_NAME}"
./arm64-to-sim2 restore "Library/${CTCC_LIBRARY_NAME}"
./arm64-to-sim2 restore "Library/${CUCC_LIBRARY_NAME}"