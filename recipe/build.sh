#!/bin/bash

if [[ "$CI" == "travis" ]]; then
  export CPU_COUNT=4
fi

autoreconf -vif .              || exit 1
./configure --prefix="$PREFIX" --enable-fmt --with-external-fmt --with-external-eigen --disable-hpcombi || exit 1
make -j${CPU_COUNT}            || exit 1
make check -j${CPU_COUNT}      || exit 1
make install
