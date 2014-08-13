FFmpeg-Android
==============

FFmpeg for Android compiled with x264, libass, fontconfig, freetype and fribidi

Supported Architecture
----
* armv7

Instructions
----
* Edit settings.sh and set ANDROID_NDK_ROOT_PATH according to your NDK root path
* Run following commands to compile ffmpeg
  1. git submodule update --init
  2. ./android_build.sh
* Find the executable binary in build directory.
