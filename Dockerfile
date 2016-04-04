FROM python:3.5
MAINTAINER Zhang Xianyi <traits.zhang@gmail.com>

RUN apt-get update -yqq \
  && apt-get install -yqq gfortran \
  && rm -rf /var/lib/apt/lists/*
