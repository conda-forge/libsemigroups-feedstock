#!/bin/bash

if [[ "$CI" == "travis" ]]; then
  export CPU_COUNT=2
fi

autoreconf -vif .              || exit 1
./configure --prefix="$PREFIX" --with-external-fmt --with-external-eigen --disable-hpcombi || exit 1
make -j${CPU_COUNT}            || exit 1
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
make check -j${CPU_COUNT}      || exit 1
fi
make install
