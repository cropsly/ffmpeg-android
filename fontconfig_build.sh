#!/bin/bash

. abi_settings.sh $1 $2

pushd fontconfig

make clean

autoreconf -ivf .

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
  --host="$NDK_TOOLCHAIN_ABI" \
  --disable-shared \
  --enable-static \
  --disable-libxml2 \
  --prefix="${TOOLCHAIN_PREFIX}" \
  --disable-iconv || exit 1

make -j${NUMBER_OF_CORES} install || exit 1

popd
