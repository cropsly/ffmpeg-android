#!/bin/bash

ANDROID_NDK_ROOT_PATH=~/Android/ndk
ANDROID_API_VERSION=android-9
export PATH=${ANDROID_NDK_ROOT_PATH}:${ANDROID_NDK_ROOT_PATH}/toolchains/arm-linux-androideabi-4.8/prebuilt/linux-x86_64/bin/:$PATH
NDK_SYSROOT=$NDK_BASE/platforms/$ANDROID_API_VERSION/arch-arm
NUMBER_OF_CORES=$(nproc)

#x264
pushd x264
make distclean
./configure \
--cross-prefix=arm-linux-androideabi- \
--sysroot="$NDK_SYSROOT" \
--host=arm-linux \
--enable-pic \
--enable-static \
--disable-cli

make -j$NUMBER_OF_CORES
popd

#ffmpeg armv7-a neon
pushd ffmpeg
./configure \
--target-os=linux \
--cross-prefix=arm-linux-androideabi- \
--arch=arm \
--cpu=armv7-a \
--sysroot="$NDK_SYSROOT" \
--disable-avdevice \
--disable-decoder=h264_vdpau \
--enable-libx264 \
--enable-gpl \
--prefix=build/armeabi-v7a-neon \
--extra-cflags='-I../x264 -DANDROID -I${ANDROID_NDK_ROOT_PATH}/sources/cxx-stl/system/include -march=armv7-a -mfloat-abi=softfp -mfpu=neon' \
--extra-ldflags='-L../x264 -Wl,--fix-cortex-a8 -L../android-libs -Wl,-rpath-link,../android-libs' \
--extra-cxxflags='-Wno-multichar -fno-exceptions -fno-rtti'
make -j$NUMBER_OF_CORES && make install && make distclean|| exit 0
popd

#ffmpeg armv7-a
pushd ffmpeg
./configure \
--target-os=linux \
--cross-prefix=arm-linux-androideabi- \
--arch=arm \
--cpu=armv7-a \
--sysroot="$NDK_SYSROOT" \
--disable-avdevice \
--disable-decoder=h264_vdpau \
--enable-libx264 \
--enable-gpl \
--prefix=build/armeabi-v7a \
--extra-cflags='-I../x264 -DANDROID -I${ANDROID_NDK_ROOT_PATH}/sources/cxx-stl/system/include -march=armv7-a -mfloat-abi=softfp' \
--extra-ldflags='-L../x264 -Wl,--fix-cortex-a8 -L../android-libs -Wl,-rpath-link,../android-libs' \
--extra-cxxflags='-Wno-multichar -fno-exceptions -fno-rtti'

make -j$NUMBER_OF_CORES && make install && make distclean|| exit 0
popd

pushd x264
make distclean
popd
