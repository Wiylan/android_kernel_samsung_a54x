#!/usr/bin/env bash

echo "=============================================="
echo "= Samsung Galaxy A54 DΛG Kernel Build Script ="
echo "=============================================="

set -e

# Toolchain paths
export PATH="$(pwd)/toolchain/clang/host/linux-x86/clang-r450784d/bin:$(pwd)/toolchain/build/kernel/build-tools/path/linux-x86/:$PATH"

# System headers/libraries
export HOSTCFLAGS="-I/usr/include"
export HOSTLDFLAGS="-L/usr/lib"

# Build variables
export DTC_FLAGS="-@"
export PLATFORM_VERSION=13
export ANDROID_MAJOR_VERSION=t
export LLVM=1
export DEPMOD=depmod
export ARCH=arm64
export TARGET_SOC=s5e8835


# Output directory
OUT_DIR=out

# Kernel configs
KERNEL_CONFIGS="a54x_defconfig"

echo "==============================="
echo "        Building Kernel "
echo "==============================="
echo "Phone: Samsung Galaxy A54"
echo "Kernel: $(make kernelversion)"
echo "ARCH: $ARCH"
echo "Android: $PLATFORM_VERSION ($ANDROID_MAJOR_VERSION)"
echo "Toolchain: clang-r450784d"
echo "Output: $(pwd)$OUT_DIR/arch/arm64/boot/"
echo "==============================="
echo ""


# Time calculation
START_TIME=$(date +%s)

# Configure kernel
make $KERNEL_CONFIGS menuconfig savedefconfig -j"$(nproc --all)" O="$OUT_DIR"

# Build kernel
make -j"$(nproc --all)" O="$OUT_DIR"

END_TIME=$(date +%s)
ELAPSED=$((END_TIME - START_TIME))
MINUTES=$((ELAPSED / 60))
SECONDS=$((ELAPSED % 60))

echo "==============================="
if [ $MINUTES -gt 0 ]; then
    echo "     Build finished in ${MINUTES}m ${SECONDS}s! "
else
    echo "     Build finished in ${SECONDS}s! "
fi
echo "==============================="
