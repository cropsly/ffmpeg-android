#!/bin/bash

. abi_settings.sh $1 $2

pushd libpng

make clean

case $1 in
  armeabi-v7a-neon)
    ARM_NEON="yes"
    ;;
  armeabi-v7a)
    ARM_NEON="no"
    ;;
esac

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
  --with-pic \
  --with-sysroot="$NDK_SYSROOT" \
  --host="$NDK_TOOLCHAIN_ABI" \
  --enable-static \
  --disable-shared \
  --prefix="${TOOLCHAIN_PREFIX}" \
  --with-pkgconfigdir="${TOOLCHAIN_PREFIX}/lib/pkgconfig" \
  --enable-arm-neon="$ARM_NEON" \
  --disable-shared || exit 1

make -j${NUMBER_OF_CORES} install || exit 1

popd
