#!/bin/bash

cd ./workspace/npu-firmware/bl0-noruntime
make -j$(nproc)

echo "编译完成，拷贝无运行时产物到 bin 目录"
cd -
mkdir -p ./bin
cp ./workspace/npu-firmware/bl0-noruntime/bootrom.elf ./bin/bootrom-noruntime.elf

cd ./workspace/npu-firmware/bl0
make -j$(nproc)

echo "编译完成，拷贝有运行时产物到 bin 目录"
cd -
mkdir -p ./bin
cp ./workspace/npu-firmware/bl0/bootrom.elf ./bin/
