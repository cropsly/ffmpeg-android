FFmpeg-Android
==============

* FFmpeg for Android compiled with x264, libass, fontconfig, freetype and fribidi
* Added Android L support

Supported Architecture
----
* armv7

Instructions
----
* Edit settings.sh and set ANDROID_NDK_ROOT_PATH according to your NDK root path
* Run following commands to compile ffmpeg
  1. sudo apt-get --quiet --yes install build-essential git autoconf libtool pkg-config gperf gettext
  2. git submodule update --init
  3. ./android_build.sh
* Find the executable binary in build directory.
* If you want to use FONTCONFIG then you need to specify your custom fontconfig config file (e.g - "FONTCONFIG_FILE=/sdcard/fonts.conf ./ffmpeg --version", where /sdcard/fonts.conf is location of your FONTCONFIG configuration file).

License
----
  check files LICENSE.GPLv3 and LICENSE
  
