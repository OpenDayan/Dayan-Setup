#!/bin/bash
gdb-multiarch -q ./bin/kernels_pack.elf \
    -ex "set confirm off" -ex "add-symbol-file ./bin/bootrom-noruntime.elf" -ex "set confirm on"\
    -ex "target remote localhost:1234" \
    -ex "b kernel_add_fp32" -ex "c"
