#!/bin/bash

pushd ./workspace/npu-qemu
mkdir -p build
pushd build
../configure --target-list=riscv64-softmmu
make -j$(nproc)

echo "编译完成，拷贝产物到 bin 目录"
popd
popd
mkdir -p ./bin
cp ./workspace/npu-qemu/build/dl-riscv64 ./bin/
