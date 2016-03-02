#!/bin/bash

script_name=$1
build_arg=$2

echo ${script_name}
echo ${build_arg}

docker run --rm -v $PWD:/io quay.io/pypa/manylinux1_x86_64 /io/${script_name} "${build_arg}"