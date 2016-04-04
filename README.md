# OpenBLAS-CI

Run OpenBLAS tests on docker

For example,

```
./run_test_helper.sh quick_test_linux.sh "TARGET=BULLDOZER USE_OPENMP=1"
./run_test_helper.sh fuill_test_linux.sh "TARGET=NEHALEM"
```

The results of the tests run by buildbot servers are continuously published at:

http://build.openblas.net/
