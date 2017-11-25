#!/bin/bash

echo "============================================"
echo "Updating submodules"
git submodule update --init
echo "============================================"
echo "Updating libpng, expat and fribidi"
# rm -rf libpng-*
# rm -rf expat-*
# rm -rf fribidi-*
# rm -rf lame-*
# rm -rf freetype-*
# rm -rf libass-*
rm -rf ffmpeg-*

# wget -O- ftp://ftp.simplesystems.org/pub/libpng/png/src/libpng16/libpng-1.6.29.tar.xz | tar xJ
# wget -O- https://downloads.sourceforge.net/project/expat/expat/2.2.0/expat-2.2.0.tar.bz2 | tar xj
# wget -O- http://fribidi.org/download/fribidi-0.19.7.tar.bz2 | tar xj
# wget -O- http://sourceforge.net/projects/lame/files/lame/3.99/lame-3.99.5.tar.gz | tar xz
# wget -O- http://download.savannah.gnu.org/releases/freetype/freetype-2.7.1.tar.bz2 | tar xz
# wget -O- https://github.com/libass/libass/releases/download/0.13.6/libass-0.13.6.tar.xz | tar xz
wget -O- https://www.ffmpeg.org/releases/ffmpeg-3.3.5.tar.bz2 | tar xz
echo "============================================"
