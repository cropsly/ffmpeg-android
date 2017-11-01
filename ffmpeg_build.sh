#!/bin/bash

. abi_settings.sh $1 $2 $3

pushd ffmpeg-3.3.5

case $1 in
  armeabi-v7a | armeabi-v7a-neon)
    CPU='cortex-a8'
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
--enable-libx264 \
--enable-pthreads \
--disable-debug \
--disable-ffserver \
--enable-version3 \
--enable-hardcoded-tables \
--disable-ffplay \
--disable-ffprobe \
--enable-yasm \
--disable-doc \
--disable-shared \
--enable-static \
--enable-nonfree \
--disable-network \
--enable-gpl \
--enable-ffmpeg \
--enable-small \
--disable-filters \
--enable-filter=copy \
--enable-filter=trim \
--enable-filter=crop \
--enable-filter=scale \
--enable-filter=format \
--pkg-config="${2}/ffmpeg-3.3-pkg-config" \
--prefix="${2}/build/${1}" \
--extra-cflags="-I${TOOLCHAIN_PREFIX}/include $CFLAGS" \
--extra-ldflags="-L${TOOLCHAIN_PREFIX}/lib $LDFLAGS" \
--extra-cxxflags="$CXX_FLAGS" \
--extra-libs="-lx264 -lm" || exit 1

# --enable-libass \
# --enable-libfreetype \
# --enable-libfribidi \
# --enable-libmp3lame \
# --enable-fontconfig \
# --extra-libs="-lpng -lexpat -lm" \

make -j${NUMBER_OF_CORES} && make install || exit 1

popd
