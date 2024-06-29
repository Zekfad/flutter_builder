# [Flutter builder](https://github.com/Zekfad/flutter_builder)

Docker image for building Android flutter apps.

## SDKs

This image contains following development kits:

* Flutter SDK 3.22.2 - June 06, 2024
* Dart 3.4.3
* JDK 11 (Adoptium Temurin)
* Android SDK:
  * Android SDK Platform 34 (`platforms;android-34`)
  * Android SDK Build-Tools 30.0.3 and 34.0.0 (`build-tools;30.0.3` and `build-tools;34.0.0` )
  * Android SDK Platform-Tools 35.0.1 (`platform-tools`)
  * Android SDK Tools 26.1.1 (`tools`)
  * NDK (Side by side) 26.3.11579264 (`ndk;26.3.11579264`)
  * Android Emulator 34.2.15 (`emulator`)
  * Android SDK Command-line Tools 13.0 (11479570 `cmdline-tools;13.0`)

> **NOTE**
>
> When running `flutter build` it will download required Android Platforms and
> build tools.

## Environment

There are following environment variables for your convenience:

* `FLUTTER_SDK_ROOT=/root/flutter-sdk`
* `ANDROID_SDK_ROOT=/root/android-sdk`
* `ANDROID_HOME=/root/android-sdk`

All SDKs binary tools are added to `PATH`.
