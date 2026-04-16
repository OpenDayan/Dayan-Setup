#!/bin/bash

cd ./workspace/npu-firmware/bl0-noruntime
make -j$(nproc)

echo "编译完成，拷贝产物到 bin 目录"
cd -
mkdir -p ./bin
cp ./workspace/npu-firmware/bl0-noruntime/bootrom.elf ./bin/
