#!/bin/bash

echo "建立工作目录 ./workspace"
mkdir -p ./workspace

echo "克隆子仓库"
git submodule update --init

# echo "1. 克隆 npu-qemu 仓库"
# git clone git@github.com:OpenRVT/npu-qemu.git -b rvtv2/dev ./workspace/npu-qemu

# echo "2. 克隆 rvtng-cmodel 仓库"
# git clone git@github.com:OpenRVT/rvtng-cmodel.git -b rvtv2/dev ./workspace/rvtng-cmodel

# echo "3. 克隆 npu-kernels 仓库"
# git clone git@github.com:OpenRVT/npu-kernels.git -b rvtv2/dev ./workspace/npu-kernels

# echo "4. 克隆 npu-firmware 仓库"
# git clone git@github.com:OpenRVT/npu-firmware.git -b master ./workspace/npu-firmware
