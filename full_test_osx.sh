#!/bin/bash
# ./full_test_osx.sh ${build_string} ${CORETYPE}
set -e

BTYPE=$1
CORETYPE=$2
ROOTDIR=$PWD

echo $BTYPE
echo $CORETYPE

cd OpenBLAS
git clean -fxd
make QUIET_MAKE=1 NUM_THREADS=64 $BTYPE
export OPENBLAS_CORETYPE=$CORETYPE
make -C test NUM_THREADS=64 $BTYPE
make -C ctest NUM_THREADS=64 $BTYPE
make -C utest NUM_THREADS=64 $BTYPE
make NUM_THREADS=64 $BTYPE lapack-test

echo "Finish"
