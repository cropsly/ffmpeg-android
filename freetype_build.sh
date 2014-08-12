#!/bin/bash

. abi_settings.sh $1 $2

pushd freetype2

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
  --with-pic \
  --with-sysroot="$NDK_SYSROOT" \
  --host="$NDK_TOOLCHAIN_ABI" \
  --enable-static \
  --disable-shared \
  --with-png=yes \
  --with-zlib=yes \
  --prefix="${TOOLCHAIN_PREFIX}" || exit 1

make -j${NUMBER_OF_CORES} && make install || exit 1
