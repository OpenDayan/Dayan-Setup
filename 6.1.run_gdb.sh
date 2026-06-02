#!/bin/bash
gdb-multiarch -q ./bin/kernels_pack.elf -ex "target remote localhost:1234" -ex "b kernel_add_fp32" -ex "c"