#!/bin/bash

./bin/llama-cli \
    -m /public/DeepSeek-R1-Distill-Qwen-1.5B/DeepSeek-R1-Distill-Qwen-1.5B-BF16.gguf \
    -ngl 29 -ctk bf16 -ctv bf16 -fa off --no-warmup -s 1 \
    -p "你好"
