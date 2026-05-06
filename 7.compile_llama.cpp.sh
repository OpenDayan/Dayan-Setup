#!/bin/bash

# 先强制编译一次 kernel
./2.compile_kernels.sh

WORKSPACE_ROOT="$(pwd)/workspace"
RT_PATH="${WORKSPACE_ROOT}/npu-runtime"
KERNEL_PATH="${WORKSPACE_ROOT}/npu-kernels"

pushd ./workspace/llama.cpp
mkdir -p build_emu

cmake -B build_emu \
      -DCMAKE_BUILD_TYPE=Release \
      -DLLAMA_CURL=OFF \
      -DBUILD_SHARED_LIBS=OFF \
      -DGGML_OPENMP=OFF \
      -DGGML_NATIVE=OFF \
      -DGGML_RNPU=ON \
      -DRNPU_RT_PATH="${RT_PATH}" \
      -DRNPU_KERNEL_PATH="${KERNEL_PATH}" \
      -DUSE_FPGA=OFF

pushd build_emu
make clean
make -j$(nproc)
popd

popd

# 拷贝产物
cp ./workspace/llama.cpp/build_emu/bin/llama-cli ./bin/
