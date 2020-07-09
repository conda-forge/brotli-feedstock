#!/bin/bash

set -e

BROTLI_CFLAGS="-O3"

# Build both static and shared libraries
cmake -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_INSTALL_LIBDIR=$PREFIX/lib \
      -DCMAKE_C_FLAGS=$BROTLI_CFLAGS \
      -GNinja \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_STATIC_LIBS=OFF \
      .

ninja
ctest -V
ninja install
