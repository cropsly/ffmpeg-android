#!/bin/bash

echo "============================================"
echo "Updating submodules"
git submodule update --init || exit 1
echo "============================================"
echo "Updating libpng, expat and fribidi"
rm -rf libpng-*
rm -rf expat-*
rm -rf fribidi-*
rm -rf lame-*

wget -O- ftp://ftp-osl.osuosl.org/pub/libpng/src/libpng16/libpng-1.6.30.tar.xz | tar xJ || exit 1
wget -O- http://downloads.sourceforge.net/project/expat/expat/2.2.1/expat-2.2.1.tar.bz2 | tar xj || exit 1
wget -O- http://fribidi.org/download/fribidi-0.19.7.tar.bz2 | tar xj || exit 1
wget -O- http://sourceforge.net/projects/lame/files/lame/3.99/lame-3.99.5.tar.gz | tar xz || exit 1
echo "============================================"
