#!/bin/bash

sed -i.bak 's/-mavx//g' Makefile.am
sed -i.bak 's/-march=native//g' Makefile.am

if [[ "$CI" == "travis" ]]; then
  export CPU_COUNT=4
fi

autoreconf -vif .              || exit 1
./configure --prefix="$PREFIX" || exit 1
make -j${CPU_COUNT}            || exit 1
make check -j${CPU_COUNT}      || exit 1
make install
