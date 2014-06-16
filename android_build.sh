#!/bin/bash

## Configure your settings here
ANDROID_NDK_ROOT_PATH=~/Android/ndk
ANDROID_API_VERSION=android-9
# including android toolchain binaries by exporting toolchains bin path to PATH variable
export PATH=${ANDROID_NDK_ROOT_PATH}:${ANDROID_NDK_ROOT_PATH}/toolchains/arm-linux-androideabi-4.8/prebuilt/linux-x86_64/bin/:$PATH
# sysroot is a GCC term for a directory containing the system headers and libraries of your target
NDK_SYSROOT=$NDK_BASE/platforms/$ANDROID_API_VERSION/arch-arm
NUMBER_OF_CORES=$(nproc) # or number of cores you want to use to compile ffmpeg

# Basic compilation in linux
# ./configure -
# This command makes the shell run the script named configure which exists in the current directory. The configure script basically 
# consists of many lines which are used to check some details about the machine on which the software is going to be installed. 
# This script checks for lots of dependencies on your system. For the particular software to work properly, it may be requiring a 
# lot of things to be existing on your machine already.  When you run the configure script you would see a lot of output on the screen, 
# each being some sort of question and a respective yes/no as the reply. If any of the major requirements are missing on your system, 
# the configure script would exit and you cannot proceed with the installation, until you get those required things. 
# The main job of the configure script is to create a Makefile. This is a very important file for the installation process. Depending on 
# the results of the tests (checks) that the configure script performed it would write down the various steps that need to be taken (while 
# compiling the software) in the file named Makefile.

# make
# make is actually a utility which exists on almost all Unix systems. For make utility to work it requires a file named Makefile in the same 
# directory in which you run make. As we have seen the configure script's main job was to create a file named Makefile to be used with make 
# utility. (Sometimes the Makefile is named as makefile also)
# make would use the directions present in the Makefile and proceed with the installation. The Makefile indicates the sequence, that Linux 
# must follow to build various components / sub-programs of your software. The sequence depends on the way the software is designed as well 
# as many other factors.
# The Makefile actually has a lot of labels (sort of names for different sections). Hence depending on what needs to be done the control would 
# be passed to the different sections within the Makefile Or it is possible that at the end of one of the section there is a command to go to 
# some next section.
# Basically the make utility compiles all your program code and creates the executables. For particular section of the program to complete might 
# require some other part of the code already ready, this is what the Makefile does. It sets the sequence for the events so that your program does 
# not complain about missing dependencies.

# make install
# As indicated before make uses the file named Makefile in the same directory. When you run make without any parameters, the instruction in the 
# Makefile begin executing from the start and as per the rules defined within the Makefile (particular sections of the code may execute after one 
# another thats why labels are used to jump from one section to another). But when you run make with install as the parameter, the make utility 
# searches for a label named install within the Makefile, and executes only that section of the Makefile.
# The install section happens to be only a part where the executables and other required files created during the last step (i.e. make) are copied 
# into the required final directories on your machine. E.g. the executable that the user runs may be copied to the /usr/local/bin so that all users 
# are able to run the software. Similarly all the other files are also copied to the standard directories in Linux. Remember that when you ran make, 
# all the executables were created in the source directory. So when you run make install, these executables are copied to the final directories.

## Donot touch anything below this line
#x264
pushd x264
make distclean

# Here we are configuring x264, you can use "cd x264 && ./configure --help" to check various configuration options for x264 library
#./configure \
#--cross-prefix=arm-linux-androideabi- \  # Prefix for compilation tools
#--sysroot="$NDK_SYSROOT" \ # ndk sysroot dir
#--host=arm-linux \ # host system for which we are compiling
#--enable-pic \ # build position-independent code
#--enable-static \ # build static library
#--disable-cli # disable cli tools

./configure \
--cross-prefix=arm-linux-androideabi- \
--sysroot="$NDK_SYSROOT" \
--host=arm-linux \
--enable-pic \
--enable-static \
--disable-cli

# building x264 where -j$NUMBER_OF_CORES speeds up the build by using multiple processor cores
make -j$NUMBER_OF_CORES
popd

#ffmpeg armv7-a neon
pushd ffmpeg
./configure \
--target-os=linux \
--cross-prefix=arm-linux-androideabi- \
--arch=arm \
--cpu=armv7-a \
--sysroot="$NDK_SYSROOT" \
--disable-avdevice \
--disable-decoder=h264_vdpau \
--enable-libx264 \
--enable-gpl \
--prefix=../build/armeabi-v7a-neon \
--extra-cflags='-I../x264 -DANDROID -I${ANDROID_NDK_ROOT_PATH}/sources/cxx-stl/system/include -march=armv7-a -mfloat-abi=softfp -mfpu=neon' \
--extra-ldflags='-L../x264 -Wl,--fix-cortex-a8 -L../android-libs -Wl,-rpath-link,../android-libs' \
--extra-cxxflags='-Wno-multichar -fno-exceptions -fno-rtti'
make -j$NUMBER_OF_CORES && make install && make distclean|| exit 0
popd

#ffmpeg armv7-a
pushd ffmpeg
./configure \
--target-os=linux \
--cross-prefix=arm-linux-androideabi- \
--arch=arm \
--cpu=armv7-a \
--sysroot="$NDK_SYSROOT" \
--disable-avdevice \
--disable-decoder=h264_vdpau \
--enable-libx264 \
--enable-gpl \
--prefix=../build/armeabi-v7a \
--extra-cflags='-I../x264 -DANDROID -I${ANDROID_NDK_ROOT_PATH}/sources/cxx-stl/system/include -march=armv7-a -mfloat-abi=softfp' \
--extra-ldflags='-L../x264 -Wl,--fix-cortex-a8 -L../android-libs -Wl,-rpath-link,../android-libs' \
--extra-cxxflags='-Wno-multichar -fno-exceptions -fno-rtti'

make -j$NUMBER_OF_CORES && make install && make distclean|| exit 0
popd

pushd x264
make distclean
popd


#Ref : http://www.codecoffee.com/tipsforlinux/articles/27.html
