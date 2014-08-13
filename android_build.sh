#!/bin/bash

. settings.sh

SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT")

for i in "${SUPPORTED_ARCHITECTURES[@]}"
do
  ./x264_build.sh $i $BASEDIR || exit 1
  ./libpng_build.sh $i $BASEDIR || exit 1
  ./freetype_build.sh $i $BASEDIR || exit 1
  ./expat_build.sh $i $BASEDIR || exit 1
  ./fribidi_build.sh $i $BASEDIR || exit 1
  ./fontconfig_build.sh $i $BASEDIR || exit 1
  ./libass_build.sh $i $BASEDIR || exit 1
#  ./ffmpeg_build.sh $i $BASEDIR || exit 1
done
