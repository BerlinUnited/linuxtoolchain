#!/bin/bash

# stop at the first error
set -e

if [ "$EXTERN_DIR" == "" ]; then
  echo ".::ERROR::. enviroment variable EXTERN_DIR was not set"
  echo ".::ERROR::. will exit"
  exit -1
fi

if [ "$1" = "check" ]; then
  if [ -f "$EXTERN_DIR/bin/premake5" ]; then
    echo "n"
    exit 0
  else
    echo "y" 
    exit 1
  fi
elif [ "$1" = "install" ]; then
  rm -Rf premake-core-master
  unzip ../downloads/premake-core-master.zip
  cd premake-core-master/
  make -f Bootstrap.mak linux
  cp bin/release/premake5 $EXTERN_DIR/bin
  cd ../ 
  pwd
fi
