#!/bin/bash
# docker build -t xianyi/openblas-ci .
# docker run --rm -v $PWD:/io xianyi/openblas-ci /io/${script_name} "${build_arg}"
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
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
pip install "cython==0.23.5" nose
pip install --no-binary=:all: "numpy==1.10.4"
pip install --no-binary=:all: "scipy==0.17.0"
pip install --no-binary=:all: "scikit-learn==0.17.1"

function np_test {
    local pkg_name=$1
    local extra_args=$2
    python -c "import sys; \
        import $pkg_name; \
        result = $pkg_name.test($extra_args); \
        sys.exit(not result.wasSuccessful())"
}

# Workaround for f2py install issue:
echo -e '#!/usr/bin/env python\nfrom numpy import f2py\nf2py.main()' > /usr/bin/f2py
chmod +x /usr/bin/f2py

np_test numpy '"full"'
np_test scipy '"full"'
nosetests sklearn
echo "Finish"
