#!/bin/bash

echo "============================================"
echo "Updating submodules"
git submodule update --init
echo "============================================"
echo "Updating libpng, expat and fribidi"
rm -rf libpng-*
rm -rf expat-*
rm -rf fribidi-*

wget -O- https://downloads.sf.net/project/libpng/libpng16/1.6.16/libpng-1.6.16.tar.xz | tar xJ
wget -O- http://downloads.sourceforge.net/project/expat/expat/2.1.0/expat-2.1.0.tar.gz | tar xz
wget -O- http://fribidi.org/download/fribidi-0.19.6.tar.bz2 | tar xj
wget -O- http://sourceforge.net/projects/lame/files/lame/3.99/lame-3.99.5.tar.gz | tar xz
echo "============================================"
