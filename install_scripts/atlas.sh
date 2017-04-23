#!/bin/bash

# stop at the first error
set -e

if [ "$EXTERN_DIR" == "" ]; then
  echo ".::ERROR::. enviroment variable EXTERN_DIR was not set"
  echo ".::ERROR::. will exit"
  exit -1
fi

if [ "$1" = "check" ]; then
  if [ -d "/usr/include/atlas/" -o -d "$EXTERN_DIR/include/atlas/" ]; then
    echo "n"
    exit 0
  else
    echo "y" 
    exit 1
  fi
elif [ "$1" = "install" ]; then
  rm -Rf ATLAS
  tar xvjf ../downloads/atlas3.10.3.tar.bz2
  cd ATLAS/
  rm -Rf build
  mkdir build && cd build
  ../configure --prefix="$EXTERN_DIR" && make && make install
  cd ../../
fi

