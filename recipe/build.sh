#!/bin/bash

set -e

# Build shared libraries
cmake -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_INSTALL_LIBDIR=$PREFIX/lib \
      -DBUILD_SHARED_LIBS=on .

make -j${CPU_COUNT}
ctest -V
make install

# Also build static libs
cmake -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_INSTALL_LIBDIR=$PREFIX/lib \
      -DBUILD_SHARED_LIBS=off .

make -j${CPU_COUNT}
make install
