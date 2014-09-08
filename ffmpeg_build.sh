#!/bin/bash

. abi_settings.sh $1 $2 $3

pushd ffmpeg

case $1 in
  armeabi-v7a | armeabi-v7a-neon )
    CPU='armv7-a'
  ;;
  x86)
    CPU='i686'
  ;;
esac

make clean

./configure \
--target-os="$TARGET_OS" \
--cross-prefix="$CROSS_PREFIX" \
--arch="$NDK_ABI" \
--cpu="$CPU" \
--enable-runtime-cpudetect \
--sysroot="$NDK_SYSROOT" \
--enable-pic \
--enable-libx264 \
--enable-libass \
--enable-libfreetype \
--enable-libfribidi \
--enable-fontconfig \
--enable-pthreads \
--disable-debug \
--disable-ffserver \
--enable-version3 \
--enable-hardcoded-tables \
--disable-ffplay \
--disable-ffprobe \
--enable-gpl \
--enable-yasm \
--disable-doc \
--disable-shared \
--enable-static \
--pkg-config="${2}/ffmpeg-pkg-config" \
--prefix="${2}/build/${1}" \
--extra-cflags="-I${TOOLCHAIN_PREFIX}/include $CFLAGS" \
--extra-ldflags="-L${TOOLCHAIN_PREFIX}/lib $LDFLAGS" \
--extra-libs="-lpng -lexpat -lm" \
--extra-cxxflags="$CXX_FLAGS" || exit 1

make -j${NUMBER_OF_CORES} && make install || exit 1

popd
