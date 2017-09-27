#!/bin/bash

set -e

BROTLI_CFLAGS="-O3"
BROTLI_CXXFLAGS="-O3"

# Build shared libraries
cmake -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_INSTALL_LIBDIR=$PREFIX/lib \
      -DCMAKE_C_FLAGS=$BROTLI_CFLAGS \
      -DCMAKE_CXX_FLAGS=$BROTLI_CXXFLAGS \
      -DBUILD_SHARED_LIBS=on .

make -j${CPU_COUNT}
ctest -V
make install

# Also build static libs
cmake -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_INSTALL_LIBDIR=$PREFIX/lib \
      -DCMAKE_C_FLAGS=$BROTLI_CFLAGS \
      -DCMAKE_CXX_FLAGS=$BROTLI_CXXFLAGS \
      -DBUILD_SHARED_LIBS=off .

make -j${CPU_COUNT}
make install
