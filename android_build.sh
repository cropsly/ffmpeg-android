#!/bin/bash

. settings.sh

BASEDIR=$(pwd)
TOOLCHAIN_PREFIX=${BASEDIR}/toolchain-android
# Applying required patches
patch  -p0 -N --dry-run --silent -f fontconfig/src/fcxml.c < android_donot_use_lconv.patch 1>/dev/null
if [ $? -eq 0 ]; then
  patch -p0 -f fontconfig/src/fcxml.c < android_donot_use_lconv.patch
fi

for i in "${SUPPORTED_ARCHITECTURES[@]}"
do
  rm -rf ${TOOLCHAIN_PREFIX}
  ./x264_build.sh $i $BASEDIR || exit 1
  ./libpng_build.sh $i $BASEDIR || exit 1
  ./freetype_build.sh $i $BASEDIR || exit 1
  ./expat_build.sh $i $BASEDIR || exit 1
  ./fribidi_build.sh $i $BASEDIR || exit 1
  ./fontconfig_build.sh $i $BASEDIR || exit 1
  ./libass_build.sh $i $BASEDIR || exit 1
  ./ffmpeg_build.sh $i $BASEDIR || exit 1
done

rm -rf ${TOOLCHAIN_PREFIX}
