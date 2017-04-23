#!/bin/bash

# stop at the first error
set -e

if [ "$EXTERN_DIR" == "" ]; then
  echo ".::ERROR::. enviroment variable EXTERN_DIR was not set"
  echo ".::ERROR::. will exit"
  exit -1
fi


if [ "$1" = "check" ]; then
  if [ -d "$EXTERN_DIR/include/caffe" ]; then
    echo "n"
    exit 0
  else
    echo "y" 
    exit 1
  fi
elif [ "$1" = "install" ]; then
  rm -Rf caffe-nao-optimized-caffe
  unzip ../downloads/nao-optimized-caffe.zip
  cd caffe-nao-optimized-caffe
  rm -Rf build
  mkdir build && cd build
  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$EXTERN_DIR -DCMAKE_PREFIX_PATH=$EXTERN_DIR -DCPU_ONLY=ON ..
  make && make install
  # install additional libraries needed by Caffe
  cp -R external/gflags-install/* $EXTERN_DIR
  cp -R external/glog-install/* $EXTERN_DIR

  cd ../../
fi
