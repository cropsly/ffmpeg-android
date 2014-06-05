ffmpeg-android
==============

ffmpeg library compiled with x264 for android

Supported Architecture
----
* armv7

Instructions
----
Run following commands to compile ffmpeg
1. git submodule init
2. git submodule update
3. configure ANDROID_NDK_ROOT_PATH in android_build.sh
4. Run ./android_build.sh to generate binary in ffmpeg/build directory
