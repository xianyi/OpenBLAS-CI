#!/bin/bash
set -e
script_name=$1
build_arg=$2

echo ${script_name}
echo ${build_arg}

docker build -t xianyi/openblas-ci .
docker run --rm -v $PWD:/io xianyi/openblas-ci /io/${script_name} "${build_arg}"
