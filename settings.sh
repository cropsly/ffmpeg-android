#!/bin/bash

SUPPORTED_ARCHITECTURES=(armeabi-v7a armeabi-v7a-neon)
ANDROID_NDK_ROOT_PATH=${ANDROID_NDK}
ANDROID_API_VERSION=9
NDK_TOOLCHAIN_ABI_VERSION=4.8

NUMBER_OF_CORES=$(nproc)
HOST_UNAME=$(uname -m)
TARGET_OS=linux

CFLAGS='-U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -fno-strict-overflow -fstack-protector-all'
LDFLAGS='-Wl,-z,relro -Wl,-z,now -pie'

CFLAGS_LIBS="-std=gnu99 -mcpu=cortex-a8 -marm -mfloat-abi=softfp"
FFMPEG_PKG_CONFIG="$(pwd)/ffmpeg-pkg-config"
