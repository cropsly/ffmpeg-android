#!/bin/bash

. abi_settings.sh $1 $2 $3

pushd libass

make clean

./autogen.sh

./configure \
  --disable-dependency-tracking \
  --with-pic \
  --host="$NDK_TOOLCHAIN_ABI" \
  --disable-enca \
  --disable-asm \
  --enable-fontconfig \
  --disable-harfbuzz \
  --enable-static \
  --disable-shared \
  --prefix="${TOOLCHAIN_PREFIX}" || exit 1

make -j${NUMBER_OF_CORES} install || exit 1

popd
