#!/bin/bash

. settings.sh

BASEDIR=$2

case $1 in
  armeabi-v7a)
    NDK_ABI='arm'
    NDK_TOOLCHAIN_ABI='arm-linux-androideabi'
    NDK_CROSS_PREFIX="${NDK_TOOLCHAIN_ABI}"
    CFLAGS="$CFLAGS -march=armv7-a"
    CFLAGS_LIBS="$CFLAGS_LIBS -mcpu=cortex-a8 -marm -mfloat-abi=softfp"
  ;;
  armeabi-v7a-neon)
    NDK_ABI='arm'
    NDK_TOOLCHAIN_ABI='arm-linux-androideabi'
    NDK_CROSS_PREFIX="${NDK_TOOLCHAIN_ABI}"
    CFLAGS="$CFLAGS -march=armv7-a -mfpu=neon"
    CFLAGS_LIBS="$CFLAGS_LIBS -mcpu=cortex-a8 -marm -mfloat-abi=softfp -mfpu=neon"
  ;;
  x86)
    NDK_ABI='x86'
    NDK_TOOLCHAIN_ABI='x86'
    NDK_CROSS_PREFIX="i686-linux-android"
    CFLAGS="$CFLAGS -march=i686"
    CFLAGS_LIBS="$CFLAGS_LIBS -march=i686"
  ;;
esac

TOOLCHAIN_PREFIX=${BASEDIR}/toolchain-android
if [ ! -d "$TOOLCHAIN_PREFIX" ]; then
  ${ANDROID_NDK_ROOT_PATH}/build/tools/make-standalone-toolchain.sh --toolchain=${NDK_TOOLCHAIN_ABI}-${NDK_TOOLCHAIN_ABI_VERSION} --platform=android-${ANDROID_API_VERSION} --install-dir=${TOOLCHAIN_PREFIX}
fi
CROSS_PREFIX=${TOOLCHAIN_PREFIX}/bin/${NDK_CROSS_PREFIX}-
NDK_SYSROOT=${TOOLCHAIN_PREFIX}/sysroot

export PKG_CONFIG_LIBDIR="${TOOLCHAIN_PREFIX}/lib/pkgconfig"

if [ $3 == 1 ]; then
  export CC="${CROSS_PREFIX}gcc --sysroot=${NDK_SYSROOT}"
  export LD="${CROSS_PREFIX}ld"
  export RANLIB="${CROSS_PREFIX}ranlib"
  export STRIP="${CROSS_PREFIX}strip"
  export READELF="${CROSS_PREFIX}readelf"
  export OBJDUMP="${CROSS_PREFIX}objdump"
  export ADDR2LINE="${CROSS_PREFIX}addr2line"
  export AR="${CROSS_PREFIX}ar"
  export AS="${CROSS_PREFIX}as"
  export CXX="${CROSS_PREFIX}g++"
  export OBJCOPY="${CROSS_PREFIX}objcopy"
  export ELFEDIT="${CROSS_PREFIX}elfedit"
  export CPP="${CROSS_PREFIX}cpp"
  export DWP="${CROSS_PREFIX}dwp"
  export GCONV="${CROSS_PREFIX}gconv"
  export GDP="${CROSS_PREFIX}gdb"
  export GPROF="${CROSS_PREFIX}gprof"
  export NM="${CROSS_PREFIX}nm"
  export SIZE="${CROSS_PREFIX}size"
  export STRINGS="${CROSS_PREFIX}strings"
fi
