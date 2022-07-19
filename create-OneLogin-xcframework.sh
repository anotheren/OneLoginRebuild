#!/bin/bash

PROJECT_NAME="OneLoginRebuild"
FRAMEWORK_NAME="OneLoginRebuild"
LIBRARY_NAME="OneLoginSDK"
PATH_PREFIX="OneLogin"

echo "[1/7] Remove last build"
if [ -d "Build/${PATH_PREFIX}/" ]; then
    rm -rf "Build/${PATH_PREFIX}/"
fi
if [ -f "${FRAMEWORK_NAME}.xcframework.zip" ]; then
    rm -rf "${FRAMEWORK_NAME}.xcframework.zip"
fi

echo "[2/7] Prepare Patch"

lipo -thin arm64 Library/${PATH_PREFIX}/${LIBRARY_NAME} -output Library/${PATH_PREFIX}/${LIBRARY_NAME}.ios-arm64
lipo -thin arm64 Library/${PATH_PREFIX}/${LIBRARY_NAME} -output Library/${PATH_PREFIX}/${LIBRARY_NAME}.ios-arm64-simulator
./arm64-to-sim Library/${PATH_PREFIX}/${LIBRARY_NAME}.ios-arm64-simulator 13
lipo -thin x86_64 Library/${PATH_PREFIX}/${LIBRARY_NAME} -output Library/${PATH_PREFIX}/${LIBRARY_NAME}.x86_64-simulator
lipo -create -output \
    Library/${PATH_PREFIX}/${LIBRARY_NAME}.ios-arm64_x86_64-simulator \
    Library/${PATH_PREFIX}/${LIBRARY_NAME}.x86_64-simulator \
    Library/${PATH_PREFIX}/${LIBRARY_NAME}.ios-arm64-simulator
rm -rf Library/${PATH_PREFIX}/${LIBRARY_NAME}.ios-arm64-simulator
rm -rf Library/${PATH_PREFIX}/${LIBRARY_NAME}.x86_64-simulator
mv Library/${PATH_PREFIX}/${LIBRARY_NAME} Library/${PATH_PREFIX}/${LIBRARY_NAME}.original

echo "[3/7] Xcode Build Archive for generic/platform=iOS"
mv Library/${PATH_PREFIX}/${LIBRARY_NAME}.ios-arm64 Library/${PATH_PREFIX}/${LIBRARY_NAME}

xcodebuild archive \
-project ${PROJECT_NAME}.xcodeproj \
-scheme ${FRAMEWORK_NAME} \
-destination "generic/platform=iOS" \
-archivePath Build/${PATH_PREFIX}/iphoneos \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
-quiet

mv Library/${PATH_PREFIX}/${LIBRARY_NAME} Library/${PATH_PREFIX}/${LIBRARY_NAME}.ios-arm64

echo "[4/7] Xcode Build Archive for generic/platform=iOS Simulator"
mv Library/${PATH_PREFIX}/${LIBRARY_NAME}.ios-arm64_x86_64-simulator Library/${PATH_PREFIX}/${LIBRARY_NAME}

xcodebuild archive \
-project ${PROJECT_NAME}.xcodeproj \
-scheme ${FRAMEWORK_NAME} \
-destination "generic/platform=iOS Simulator" \
-archivePath Build/${PATH_PREFIX}/iphonesimulator \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
-quiet

mv Library/${PATH_PREFIX}/${LIBRARY_NAME} Library/${PATH_PREFIX}/${LIBRARY_NAME}.ios-arm64_x86_64-simulator

echo "[5/7] Create xcframework"
xcodebuild -create-xcframework \
-framework Build/${PATH_PREFIX}/iphoneos.xcarchive/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
-framework Build/${PATH_PREFIX}/iphonesimulator.xcarchive/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
-output Build/${FRAMEWORK_NAME}.xcframework

echo "[6/7] Create Zip & Compute Checksum"
zip -r ${FRAMEWORK_NAME}.xcframework.zip Build/${FRAMEWORK_NAME}.xcframework -q
swift package compute-checksum ${FRAMEWORK_NAME}.xcframework.zip

echo "[7/7] Clean"
rm -rf Library/${PATH_PREFIX}/${LIBRARY_NAME}.ios-arm64_x86_64-simulator
rm -rf Library/${PATH_PREFIX}/${LIBRARY_NAME}.ios-arm64
mv Library/${PATH_PREFIX}/${LIBRARY_NAME}.original Library/${PATH_PREFIX}/${LIBRARY_NAME}