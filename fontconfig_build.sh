#!/bin/bash

. abi_settings.sh $1 $2 $3

pushd fontconfig

make clean

autoreconf -ivf

./configure \
  --with-pic \
  --host="$NDK_TOOLCHAIN_ABI" \
  --disable-shared \
  --enable-static \
  --disable-libxml2 \
  --prefix="${TOOLCHAIN_PREFIX}" \
  --disable-iconv || exit 1

make -j${NUMBER_OF_CORES} install || exit 1

popd
