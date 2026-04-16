#!/bin/bash
gdb-multiarch -q ./bin/kernels_pack.elf -ex "target remote localhost:1234" -ex "b test_elem_add_fp32_kernel" -ex "c"