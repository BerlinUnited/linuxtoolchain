#!/bin/bash

# stop at the first error
set -e

if [ "$EXTERN_DIR" == "" ]; then
  echo ".::ERROR::. enviroment variable EXTERN_DIR was not set"
  echo ".::ERROR::. will exit"
  exit -1
fi


if [ "$1" = "check" ]; then
  if [ -d "/usr/include/opencv2" -o -d "$EXTERN_DIR/include/opencv2" ]; then
    echo "n"
    exit 0
  else
    echo "y"
    exit 1
  fi
elif [ "$1" = "install" ]; then
  export CMAKE_LIBRARY_PATH="$EXTERN_DIR/lib"
  export CMAKE_INCLUDE_PATH="$EXTERN_DIR/include"
  rm -Rf opencv-3.1.0
  tar xvf ../downloads/opencv-3.1.0.tar.xz
  cd opencv-3.1.0
  rm -Rf build
  mkdir build && cd build
  cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX="$EXTERN_DIR" -DBUILD_opencv_apps=OFF -D BUILD_DOCS=OFF -DBUILD_TESTS=OFF -DBUILD_opencv_java=OFF \
  -DBUILD_opencv_python2=OFF -DBUILD_opencv_python3=OFF -DBUILD_PERF_TESTS=OFF -DENABLE_PRECOMPILED_HEADERS=OFF -DBUILD_LIST=core,improc,ml,objdetect -DWITH_CUDA=OFF -DWITH_FFMPEG=OFF ..
  make && make install

  cd ../../
fi
