#!/bin/bash

# stop at the first error
set -e

if [ "$EXTERN_DIR" == "" ]; then
  echo ".::ERROR::. enviroment variable EXTERN_DIR was not set"
  echo ".::ERROR::. will exit"
  exit -1
fi

if [ "$1" = "check" ]; then
  if [ -f "/usr/include/fftw3.h" -o -f "$EXTERN_DIR/include/fftw3.h" ]; then
    echo "n"
    exit 0
  else
    echo "y" 
    exit 1
  fi
elif [ "$1" = "install" ]; then
  rm -Rf fftw-3.3.5
  tar xvzf ../downloads/fftw-3.3.5.tar.gz
  cd fftw-3.3.5
  ./configure --prefix="$EXTERN_DIR" && make && make install
  cd ..  
fi