#!/bin/bash
set -e

BASE_DIRECTORY=$(pwd)

###############################
# Building the Cross Compiler #
###############################

export PREFIX="$BASE_DIRECTORY/compiler"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$PATH"

mkdir -p $BASE_DIRECTORY/compiler
mkdir -p $BASE_DIRECTORY/build_cross/build_binutils
mkdir -p $BASE_DIRECTORY/build_cross/build_gcc

# Downloading Source Code
git clone git://sourceware.org/git/binutils-gdb.git $BASE_DIRECTORY/build_cross/binutils
git clone git://gcc.gnu.org/git/gcc.git $BASE_DIRECTORY/build_cross/gcc

# Build Binutils
cd $BASE_DIRECTORY/build_cross/build_binutils
../binutils/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
make && make install

# Build GCC
which -- $TARGET-as || (echo "$TARGET-as is not in the PATH" && exit 1)

cd $BASE_DIRECTORY/build_cross/build_gcc
../gcc/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c --without-headers
make all-gcc && make all-target-libgcc && make install-gcc && make install-target-libgcc

cd $BASE_DIRECTORY

# Cleanup
rm -rf $BASE_DIRECTORY/build_cross

tree .
echo $PATH
