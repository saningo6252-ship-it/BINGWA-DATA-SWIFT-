name: Build Android APK

on:
  push:
    branches:
      - main
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Set up Java
        uses: actions/setup-java@v4
        with:
          distribution: 'temurin'
          java-version: '17'

      - name: Set up Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.24.0'
          channel: 'stable'

      - name: Ensure Android Gradle structure
        run: flutter create --platforms=android --project-name bingwa_data_swift .

      - name: Update Kotlin Gradle plugin version
        run: |
          if [ -f android/settings.gradle ]; then
            sed -i -E 's/(id "org\.jetbrains\.kotlin\.android" version ")[0-9.]+(")/\12.0.20\2/g' android/settings.gradle
          fi
          if [ -f android/settings.gradle.kts ]; then
            sed -i -E 's/(id\("org\.jetbrains\.kotlin\.android"\) version ")[0-9.]+(")/\12.0.20\2/g' android/settings.gradle.kts
          fi

      - name: Install dependencies
        run: flutter pub get

      - name: Build release APK
        run: flutter build apk --release

      - name: Upload APK artifact
        uses: actions/upload-artifact@v4
        with:
          name: bingwa-data-swift-release-apk
          path: build/app/outputs/flutter-apk/app-release.apk
