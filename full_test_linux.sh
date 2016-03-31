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

# Run python tests
export PATH=/opt/2.7/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
pip install "cython==0.23.5" nose
pip install "numpy==1.10.4"
pip install "scipy==0.17.0"
pip install "scikit-learn==0.17.1"

function np_test {
    local pkg_name=$1
    local extra_args=$2
    python -c "import sys; \
        import $pkg_name; \
        result = $pkg_name.test($extra_args); \
        sys.exit(not result.wasSuccessful())"
}

np_test numpy '"full", verbose=3'
np_test scipy '"full", verbose=3'
nosetests sklearn
echo "Finish"
