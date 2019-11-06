#!/bin/bash

# stop at the first error
set -e

if [ "$EXTERN_DIR" == "" ]; then
  echo ".::ERROR::. enviroment variable EXTERN_DIR was not set"
  echo ".::ERROR::. will exit"
  exit -1
fi

if [ "$1" = "check" ]; then
  # don't check global install since we have to be sure to have the same version of protobuf on
  # our computer as the one on the Nao
  if [ -d "$EXTERN_DIR/include/turbojpeg/" ]; then
    echo "n"
    exit 0
  else
    echo "y" 
    exit 1
  fi
elif [ "$1" = "install" ]; then
  rm -Rf libjpeg-turbo-2.0.3
  tar xvzf ../downloads/libjpeg-turbo-2.0.3.tar.gz
  cd libjpeg-turbo-2.0.3
  mkdir build && cd build
  cmake -G"Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$EXTERN_DIR -DCMAKE_INSTALL_LIBDIR="$EXTERN_DIR/lib" -DCMAKE_INSTALL_INCLUDEDIR="$EXTERN_DIR/include/turbojpeg" .. && make && make install
  cd ..  
fi
