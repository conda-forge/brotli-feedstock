#!/bin/bash

set -e

cmake -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DBUILD_SHARED_LIBS=on .

make -j${CPU_COUNT}
ctest -V
make install
