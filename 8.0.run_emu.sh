#!/bin/bash

./bin/rvt_emulator \
    ./bin/dl-riscv64 -monitor null \
    -bios ./bin/bootrom.elf \
    -machine rvtng-v0 -m 4096 \
    -nographic -smp 1
