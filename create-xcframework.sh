#!/bin/bash

echo "✅ Start build CMCC"
sh create-CMCC-xcframework.sh

echo "✅ Start build CTCC"
sh create-CTCC-xcframework.sh

echo "✅ Start build CUCC"
sh create-CUCC-xcframework.sh

echo "✅ Start build OneLoginRebuild"
sh create-OneLogin-xcframework.sh