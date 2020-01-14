#!/bin/bash

if [[ "$CI" == "travis" ]]; then
  export CPU_COUNT=4
fi

autoreconf -vif .              || exit 1
./configure --prefix="$PREFIX" --with-external-fmt --disable-hpcombi || exit 1
make -j${CPU_COUNT}            || exit 1
make check -j${CPU_COUNT}      || exit 1
make install
