#!/bin/bash
# docker build -t xianyi/openblas-ci .
# docker run --rm -v $PWD:/io xianyi/openblas-ci /io/${script_name} "${build_arg}"
set -e
git clone https://github.com/xianyi/OpenBLAS
cd OpenBLAS
BTYPE=$1
echo $BTYPE
make QUIET_MAKE=1 NUM_THREADS=64 $BTYPE
make -C test NUM_THREADS=64 $BTYPE
make -C ctest NUM_THREADS=64 $BTYPE
make -C utest NUM_THREADS=64 $BTYPE
make NUM_THREADS=64 $BTYPE install
echo "Finish"
