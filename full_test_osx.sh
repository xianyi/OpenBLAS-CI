#!/bin/bash
# ./full_test_osx.sh ${build_string} ${CORETYPE}
set -ex

BTYPE=$1
CORETYPE=$2
ROOTDIR=$PWD

echo $BTYPE
echo $CORETYPE

cd OpenBLAS
git clean -qfxd
make QUIET_MAKE=1 NUM_THREADS=64 $BTYPE
export OPENBLAS_CORETYPE=$CORETYPE
make -C test NUM_THREADS=64 $BTYPE
make -C ctest NUM_THREADS=64 $BTYPE
make -C utest NUM_THREADS=64 $BTYPE
make NUM_THREADS=64 $BTYPE lapack-test
mkdir -p /opt
make NUM_THREADS=64 $BTYPE PREFIX=/opt/OpenBLAS install

# gfortran is provided by Homebrew as part of the gcc package
brew update
brew install gcc

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

np_test numpy '"full", verbose=3'
np_test scipy '"full", verbose=3'
nosetests -v sklearn
echo "Finish"
