#!/bin/bash

# stop at the first error
set -e

if [ "$EXTERN_DIR" == "" ]; then
  echo ".::ERROR::. enviroment variable EXTERN_DIR was not set"
  echo ".::ERROR::. will exit"
  exit -1
fi


if [ "$1" = "check" ]; then
  if [ -d "/usr/include/hdf5" -o -d "$EXTERN_DIR/include/hdf5" ]; then
    echo "n"
    exit 0
  else
    echo "y" 
    exit 1
  fi
elif [ "$1" = "install" ]; then
  export CMAKE_LIBRARY_PATH="$EXTERN_DIR/lib"
  export CMAKE_INCLUDE_PATH="$EXTERN_DIR/include"
  rm -Rf hdf5-1.10.0-patch1
  tar xvzf ../downloads/hdf5-1.10.0-patch1.tar.gz
  cd hdf5-1.10.0-patch1
  rm -Rf build
  mkdir build && cd build
  cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX="$EXTERN_DIR" ..
  make && make install

  cd ../../
fi
