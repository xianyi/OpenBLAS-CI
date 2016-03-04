#!/bin/bash
# ./quick_test_osx.sh ${build_string} ${CORETYPE}
set -e
cd OpenBLAS
BTYPE=$1
CORETYPE=$2
echo $BTYPE
echo $CORETYPE
git clean -fxd
make QUIET_MAKE=1 NUM_THREADS=64 $BTYPE
export OPENBLAS_CORETYPE=$CORETYPE
make -C test NUM_THREADS=64 $BTYPE
make -C ctest NUM_THREADS=64 $BTYPE
make -C utest NUM_THREADS=64 $BTYPE
echo "Finish"
