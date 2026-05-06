#!/bin/bash

cd ./workspace/npu-kernels
make clean
make -j$(nproc)

echo "编译完成，拷贝产物到 bin 目录"
cd -
mkdir -p ./bin
cp ./workspace/npu-kernels/bin/kernels_pack.elf ./bin/
cp ./workspace/npu-kernels/bin/kernels_pack.elf.objdump ./bin/
