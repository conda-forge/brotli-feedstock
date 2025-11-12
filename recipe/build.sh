#!/bin/bash

set -exuo pipefail

BROTLI_CFLAGS="-O3"

# Build both static and shared libraries
cmake ${CMAKE_ARGS} -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_C_FLAGS=$BROTLI_CFLAGS \
      -GNinja \
      -DCMAKE_BUILD_TYPE=Release \
      .

ninja
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR:-}" != "" ]]; then
  if [[ "${QEMU_LD_PREFIX:-}" != "" ]]; then
    EXTRA_CTEST_FLAGS=-DBROTLI_WRAPPER_LD_PREFIX="${QEMU_LD_PREFIX:-}"
  fi
  ctest -V ${EXTRA_CTEST_FLAGS:-}
fi
