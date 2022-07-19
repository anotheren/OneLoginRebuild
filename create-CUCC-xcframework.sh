#!/bin/bash

PROJECT_NAME="OneLoginRebuild"
FRAMEWORK_NAME="CUCC"
LIBRARY_NAME="account_login_sdk_noui_core"
PATH_PREFIX="CUCC"

echo "[1/6] Remove last build"
if [ -d "Build/${PATH_PREFIX}/" ]; then
    rm -rf "Build/${PATH_PREFIX}/"
fi
if [ -f "${FRAMEWORK_NAME}.xcframework.zip" ]; then
    rm -rf "${FRAMEWORK_NAME}.xcframework.zip"
fi

echo "[2/6] Xcode Build Archive for generic/platform=iOS"
xcodebuild archive \
-project ${PROJECT_NAME}.xcodeproj \
-scheme ${FRAMEWORK_NAME} \
-destination "generic/platform=iOS" \
-archivePath "Build/${PATH_PREFIX}/iphoneos" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
-quiet

echo "[3/6] Xcode Build Archive for generic/platform=iOS Simulator"
./arm64-to-sim2 patch Library/${PATH_PREFIX}/${LIBRARY_NAME}

xcodebuild archive \
-project ${PROJECT_NAME}.xcodeproj \
-scheme ${FRAMEWORK_NAME} \
-destination "generic/platform=iOS Simulator" \
-archivePath "Build/${PATH_PREFIX}/iphonesimulator" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
-quiet

echo "[4/6] Create xcframework"
xcodebuild -create-xcframework \
-framework "Build/${PATH_PREFIX}/iphoneos.xcarchive/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework" \
-framework "Build/${PATH_PREFIX}/iphonesimulator.xcarchive/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework" \
-output "Build/${FRAMEWORK_NAME}.xcframework"

echo "[5/6] Create Zip & Compute Checksum"
zip -r ${FRAMEWORK_NAME}.xcframework.zip Build/${FRAMEWORK_NAME}.xcframework -q
swift package compute-checksum ${FRAMEWORK_NAME}.xcframework.zip

echo "[6/6] Clean"
./arm64-to-sim2 restore Library/${PATH_PREFIX}/${LIBRARY_NAME}
