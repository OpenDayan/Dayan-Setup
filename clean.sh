#!/bin/bash

# 清理构建产物

pushd workspace/

    pushd llama.cpp
        rm -rf build_emu
    popd

    pushd npu-firmware
        pushd bl0
            make clean
        popd
        pushd bl0-noruntime
            make clean
        popd
    popd

    pushd npu-kernels
        make clean
    popd

    pushd npu-qemu
        rm -rf build
    popd

    pushd rvtng-cmodel
        make clean
    popd

popd
