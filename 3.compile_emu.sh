#!/bin/bash

echo "进入目录 rvtng-cmodel，编译仿真器..."
cd ./workspace/rvtng-cmodel
make -j$(nproc)

echo "编译完成，拷贝产物到 bin 目录"
cd -
cp ./workspace/rvtng-cmodel/bin/* ./bin/
