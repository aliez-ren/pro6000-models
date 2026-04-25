#!/usr/bin/env bash

docker rm -f sglang-minimax-m2-7-nvfp4

docker run --device "nvidia.com/gpu=all" \
  --name sglang-minimax-m2-7-nvfp4 \
  --ipc=host --shm-size=8g --network=host \
  -d \
  -v /root/.cache/huggingface:/root/.cache/huggingface \
  -v jit-cache:/cache/jit \
  -e SGLANG_ENABLE_SPEC_V2=True \
  voipmonitor/sglang:cu130 \
  python -m sglang.launch_server \
    --model nvidia/MiniMax-M2.7-NVFP4 \
    --reasoning-parser minimax-append-think \
    --tool-call-parser minimax-m2 \
    --tp-size 2 \
    --enable-torch-compile \
    --trust-remote-code \
    --quantization modelopt_fp4 \
    --kv-cache-dtype bf16 \
    --moe-runner-backend b12x \
    --fp4-gemm-backend b12x \
    --attention-backend flashinfer \
    --enable-pcie-oneshot-allreduce \
    --mem-fraction-static 0.85 \
    --host 0.0.0.0 --port 8000

docker logs -f sglang-minimax-m2-7-nvfp4
