#!/bin/bash

set -e

BROTLI_CFLAGS="-O3"

# Build shared libraries only (CFEP-18).
cmake ${CMAKE_ARGS} -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_INSTALL_LIBDIR=$PREFIX/lib \
      -DCMAKE_C_FLAGS=$BROTLI_CFLAGS \
      -DCMAKE_INSTALL_LIBDIR=$PREFIX/lib \
      -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
      -DBUILD_STATIC_LIBS=OFF \
      -GNinja \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_STATIC_LIBS=OFF \
      .

ninja
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
  ctest -V
fi
# ninja install
