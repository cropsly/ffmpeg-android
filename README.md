FFmpeg-Android
==============

* FFmpeg for Android compiled with x264, libass, fontconfig, freetype and fribidi
* Added Android L support

Supported Architecture
----
* armv7

Instructions
----
* Set environment variable
  1. export ANDROID_NDK=<Android NDK Base Path>
* Run following commands to compile ffmpeg
  1. sudo apt-get --quiet --yes install build-essential git autoconf libtool pkg-config gperf gettext
  2. git submodule update --init
  3. ./android_build.sh
* Find the executable binary in build directory.
* If you want to use FONTCONFIG then you need to specify your custom fontconfig config file (e.g - "FONTCONFIG_FILE=/sdcard/fonts.conf ./ffmpeg --version", where /sdcard/fonts.conf is location of your FONTCONFIG configuration file).
* You can also download [prebuilt-binaries](releases/download/v0.1.0/prebuilt-binaries.tar.gz) here.

License
----
  check files LICENSE.GPLv3 and LICENSE
