#!/bin/bash
set -e

echo "🔧 Checking for Flutter..."
if ! command -v flutter &> /dev/null
then
    echo "❌ Flutter is not installed or not in PATH. Please install it."
    exit 1
fi

echo "🧹 Cleaning old builds..."
flutter clean

echo "📦 Getting dependencies..."
flutter pub get

echo "🚀 Building release APK..."
flutter build apk --release

echo "✅ APK Build Complete at build/app/outputs/flutter-apk/app-release.apk"
