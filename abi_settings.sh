#!/bin/bash

. settings.sh

BASEDIR=$2

case $1 in
  armeabi-v7a)
    NDK_ABI='arm'
    NDK_TOOLCHAIN_ABI='arm-linux-androideabi'
    ARCH_CPU='armv7-a'
    CFLAGS="$CFLAGS_LIBS -march=$ARCH_CPU"
  ;;
  armeabi-v7a-neon)
    NDK_ABI='arm'
    NDK_TOOLCHAIN_ABI='arm-linux-androideabi'
    ARCH_CPU='armv7-a'
    CFLAGS="$CFLAGS -march=$ARCH_CPU -mfpu=neon"
    CFLAGS_LIBS="$CFLAGS_LIBS -mfpu=neon"
  ;;
esac

TOOLCHAIN_PREFIX=${BASEDIR}/toolchain-android
if [ ! -d "$TOOLCHAIN_PREFIX" ]; then
  ${ANDROID_NDK_ROOT_PATH}/build/tools/make-standalone-toolchain.sh --toolchain=${NDK_TOOLCHAIN_ABI}-${NDK_TOOLCHAIN_ABI_VERSION} --platform=android-${ANDROID_API_VERSION} --install-dir=${TOOLCHAIN_PREFIX}
fi
CROSS_PREFIX=${TOOLCHAIN_PREFIX}/bin/${NDK_TOOLCHAIN_ABI}-
NDK_SYSROOT=${TOOLCHAIN_PREFIX}/sysroot
CC="${CROSS_PREFIX}gcc --sysroot=${NDK_SYSROOT}"
LD="${CROSS_PREFIX}ld"
RANLIB="${CROSS_PREFIX}ranlib"
STRIP="${CROSS_PREFIX}strip"
READELF="${CROSS_PREFIX}readelf"
OBJDUMP="${CROSS_PREFIX}objdump"
ADDR2LINE="${CROSS_PREFIX}addr2line"
AR="${CROSS_PREFIX}ar"
AS="${CROSS_PREFIX}as"
CXX="${CROSS_PREFIX}g++"
OBJCOPY="${CROSS_PREFIX}objcopy"
ELFEDIT="${CROSS_PREFIX}elfedit"
CPP="${CROSS_PREFIX}cpp"
DWP="${CROSS_PREFIX}dwp"
GCONV="${CROSS_PREFIX}gconv"
GDP="${CROSS_PREFIX}gdb"
GPROF="${CROSS_PREFIX}gprof"
NM="${CROSS_PREFIX}nm"
SIZE="${CROSS_PREFIX}size"
STRINGS="${CROSS_PREFIX}strings"
