#!/bin/bash

PROJECT_NAME="OneLoginRebuild"
FRAMEWORK_NAME="CMCC"
LIBRARY_NAME="TYRZUISDK"
PATH_PREFIX="CMCC"

echo "[1/6] Remove last build"
if [ -d "Build/${PATH_PREFIX}/" ]; then
    rm -rf "Build/${PATH_PREFIX}/"
fi
if [ -f "${FRAMEWORK_NAME}.xcframework.zip" ]; then
    rm -rf "${FRAMEWORK_NAME}.xcframework.zip"
fi

echo "[2/6] Prepare ios_arm64"
mkdir -p TMP/ios_arm64/TYRZUISDK.framework/
cp -R Library/TYRZUISDK.framework/ TMP/ios_arm64/TYRZUISDK.framework/
lipo -thin arm64 TMP/ios_arm64/TYRZUISDK.framework/TYRZUISDK -output TMP/ios_arm64/TYRZUISDK.framework/TYRZUISDK

echo "[3/6] Prepare ios_arm64_x86_64_simulator"
mkdir -p TMP/ios_arm64_x86_64_simulator/TYRZUISDK.framework/
cp -R Library/TYRZUISDK.framework/ TMP/ios_arm64_x86_64_simulator/TYRZUISDK.framework/
# lipo -thin arm64 TMP/ios_arm64_x86_64_simulator/TYRZUISDK.framework/TYRZUISDK -output TMP/ios_arm64_x86_64_simulator/TYRZUISDK.framework/TYRZUISDK.arm64
# lipo -thin x86_64 TMP/ios_arm64_x86_64_simulator/TYRZUISDK.framework/TYRZUISDK -output TMP/ios_arm64_x86_64_simulator/TYRZUISDK.framework/TYRZUISDK.x86_64
./Library/arm64-to-sim2 patch TMP/ios_arm64_x86_64_simulator/TYRZUISDK.framework/TYRZUISDK.arm64


echo "[3/6] Xcode Build Archive for generic/platform=iOS Simulator"
./arm64-to-sim2 patch Library/${PATH_PREFIX}/${LIBRARY_NAME}



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
