# [Flutter builder](https://github.com/Zekfad/flutter_builder)

Docker image for building Android flutter apps.

## SDKs

This image contains following development kits:

* Flutter SDK (3.13.4)
* JDK 11 (Adoptium Temurin)
* Android SDK:
  * Android SDK Platform 34
  * Build tools 34.0.0
  * Command line tools 11.0 (10406996)

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
