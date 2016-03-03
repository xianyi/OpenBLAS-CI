#!/bin/bash
#    docker run --rm -v $PWD:/io quay.io/pypa/manylinux1_x86_64 /io/full_test_linux.sh ${build_string}
set -e
git clone https://github.com/xianyi/OpenBLAS
git clone https://github.com/xianyi/BLAS-Tester
cd OpenBLAS
BTYPE=$1
echo $BTYPE
make QUIET_MAKE=1 NUM_THREADS=64 $BTYPE
make -C test NUM_THREADS=64 $BTYPE
make -C ctest NUM_THREADS=64 $BTYPE
make -C utest NUM_THREADS=64 $BTYPE
make NUM_THREADS=64 $BTYPE lapack-test
make NUM_THREADS=64 $BTYPE install
make NUM_THREADS=64 $BTYPE PREFIX=/usr/local install
# For BLAS-Tester
cd ../BLAS-Tester
echo "Building BLAS-Tester"
make NUMTHREADS=64 TEST_BLAS=/opt/OpenBLAS/lib/libopenblas.a $BTYPE
cd bin
echo "Running BLAS-Tester"
/io/run_blas_tester.sh

# Run python test
export PATH=/opt/2.7/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
MANYLINUX_URL=https://nipy.bic.berkeley.edu/manylinux
pip install -f $MANYLINUX_URL "cython==0.22.1" nose
pip install "numpy==1.10.4"
pip install "scipy==0.17.0"
python -c 'import scipy.linalg; scipy.linalg.test()'
echo "Finish"