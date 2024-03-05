#!/bin/bash

echo "==============================================================================="
echo "=======================EXPORTING PATHS===================================="
echo 'export HOME=$(pwd)' 
echo 'export DIR=${HOME}/apps/Library'
echo 'export PATH=$DIR/bin:$PATH'
echo 'export LD_LIBRARY_PATH=$DIR/lib:$LD_LIBRARY_PATH'
echo 'export CPPFLAGS=-I$DIR/Library/include'
echo 'export LDFLAGS=-L$DIR/Library/lib'
sleep 5
export HOME=$(pwd)
export DIR=${HOME}/apps/Library
export PATH=$DIR/bin:$PATH
export LD_LIBRARY_PATH=$DIR/lib:$LD_LIBRARY_PATH
export CPPFLAGS=-I$DIR/Library/include
export LDFLAGS=-L$DIR/Library/lib
echo "==============================================================================="
echo "=======================EXPORTING PARAMETERS===================================="
echo "export CC=gcc"
echo "export CXX=g++"
echo "export FC=gfortran"
echo "export F77=gfortran"
echo "export ecCodes=ecCodes-2.34.1"
sleep 5
export CC=gcc
export CXX=g++
export FC=gfortran
export F77=gfortran
export ecCodes=ecCodes-2.34.1

echo "==============================================================================="
echo "=======================DOWNLOADING SOURCE CODE===================================="
if [ -f "$HOME/$ecCodes.tar.gz" ]; then
    echo "$HOME/$ecCodes.tar.gz already exists!"
else
    echo 'wget -q 'https://confluence.ecmwf.int/download/attachments/45757960/eccodes-2.34.1-Source.tar.gz?api=v2' -O $HOME/$ecCodes.tar.gz'
    sleep $DT
    wget -q 'https://confluence.ecmwf.int/download/attachments/45757960/eccodes-2.34.1-Source.tar.gz?api=v2' -O $HOME/${ecCodes}.tar.gz
fi
sleep 5
echo "==============================================================================="
echo "=======================COMPILING===================================="
echo 'cd $HOME'
echo 'tar -xvzf ${ecCodes}.tar.gz'
echo 'cd ${ecCodes}'
echo "mkdir build"
echo "cd ./build"
echo "cmake .."
echo "make"
sleep 5
cd $HOME
tar -xvzf ${ecCodes}.tar.gz
cd ${ecCodes}
mkdir build 
cd ./build 
cmake .. 
make
