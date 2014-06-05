ffmpeg-android
==============

ffmpeg library compiled with x264 for android

Supported Architecture
----
* armv7

Instructions
----
* Edit android_build.sh and set ANDROID_NDK_ROOT_PATH according to your NDK root path
* Run following commands to compile ffmpeg
1. git submodule init
2. git submodule update
3. ./android_build.sh
* Find the binary executable in ffmpeg/build directory.

