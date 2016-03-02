#!/bin/bash
#    docker run --rm -v $PWD:/io quay.io/pypa/manylinux1_x86_64 /io/full_test_linux.sh ${build_string}

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