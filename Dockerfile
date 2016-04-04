FROM python:2.7
MAINTAINER Zhang Xianyi <traits.zhang@gmail.com>
# Python 2.7 is required by lapack-netlib/lapack_testing.py

RUN apt-get update -yqq \
  && apt-get install -yqq gfortran \
  && rm -rf /var/lib/apt/lists/*
