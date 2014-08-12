#!/bin/bash

. abi_settings.sh $1 $2

pushd libass

make clean

./autogen.sh

./configure \
  CC="$CC" \
  LD="$LD" \
  RANLIB="$RANLIB" \
  STRIP="$STRIP" \
  READELF="$READELF" \
  OBJDUMP="$OBJDUMP" \
  ADDR2LINE="$ADDR2LINE" \
  AR="$AR" \
  AS="$AS" \
  CXX="$CXX" \
  OBJCOPY="$OBJCOPY" \
  ELFEDIT="$ELFEDIT" \
  CPP="$CPP" \
  DWP="$DWP" \
  GCONV="$GCONV" \
  GDP="$GDP" \
  GPROF="$GPROF" \
  NM="$NM" \
  SIZE="$SIZE" \
  STRINGS="$STRINGS" \
  CFLAGS="$CFLAGS_LIBS" \
  PKG_CONFIG_LIBDIR="${TOOLCHAIN_PREFIX}/lib/pkgconfig" \
  --disable-dependency-tracking \
  --with-pic \
  --host="$NDK_TOOLCHAIN_ABI" \
  --disable-enca \
  --enable-fontconfig \
  --disable-harfbuzz \
  --enable-static \
  --disable-shared \
  --prefix="${TOOLCHAIN_PREFIX}" || exit 1

make -j${NUMBER_OF_CORES} install || exit 1

popd
