#!/bin/sh
set -e

OS_NAME=cyclone
BIN_NAME=$OS_NAME.bin
ISO_NAME=$OS_NAME.iso

# Clear out build directory
rm -rf build/ && mkdir build/

#########################
# Compile & Link Kernel #
#########################

C_STD_ARGS="-std=gnu99 -ffreestanding -O2 -Wall -Wextra"

i686-elf-as src/boot.s -o build/boot.o
i686-elf-gcc src/kernel.c -c -o build/kernel.o $C_STD_ARGS -Ilibc
i686-elf-gcc -T src/linker.ld -o build/$BIN_NAME -ffreestanding -O2 -nostdlib build/boot.o build/kernel.o -lgcc

#############################
# Deploying Kernel to Image #
#############################

# Check Validity of operating system binary
if grub-file --is-x86-multiboot build/$BIN_NAME; then
	echo "[INFO] Multiboot Confirmed"
else
	echo "[ERROR]" ${BIN_NAME} "is not multiboot"
	exit 1
fi

exit 0

mkdir -p isodir/boot/grub
cp build/$BIN_NAME isodir/boot/$BIN_NAME
cp src/grub.cfg    isodir/boot/grub/grub.cfg
grub-mkrescue -o $ISO_NAME isodir
rm -rf isodir
