#!/bin/bash
set -e

###############################
# Install Nessessary Programs #
###############################

# Building Cross Compiler
sudo apt install git build-essential g++ bison flex libgmp3-dev libmpc-dev libmpfr-dev texinfo -y

# Saving Kernel to ISO
sudo apt install grub-common xorriso -y

###############################
# Building the Cross Compiler #
###############################

# chmod u=rwx,g=rw,o=r scripts/build_cross_compiler.sh
./scripts/build_cross_compiler.sh
