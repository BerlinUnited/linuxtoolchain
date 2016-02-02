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
  rm -Rf opencv-3.0.0
  tar xvzf ../downloads/opencv-3.1.0.tar.gz
  cd opencv-3.1.0
  mkdir build && cd build
  cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX="$EXTERN_DIR" ..
  make && make install
  cd ..  
fi

