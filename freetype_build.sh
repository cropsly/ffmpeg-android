#!/bin/bash

. abi_settings.sh $1 $2 $3

pushd freetype-2.7.1

make clean

./autogen.sh

./configure \
  --with-pic \
  --with-sysroot="$NDK_SYSROOT" \
  --host="$NDK_TOOLCHAIN_ABI" \
  --enable-static \
  --disable-shared \
  --with-png=yes \
  --with-zlib=yes \
  --prefix="${TOOLCHAIN_PREFIX}" || exit 1

make -j${NUMBER_OF_CORES} && make install || exit 1
