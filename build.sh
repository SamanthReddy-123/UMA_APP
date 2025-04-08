#!/bin/bash

echo "🛠️ Simulating APK build..."

# Create build directory
mkdir -p build

# Simulate APK generation
echo "This is a dummy APK for testing purposes. Generated at: $(date)" > build/app-debug.apk

echo "✅ Dummy APK created at build/app-debug.apk"
