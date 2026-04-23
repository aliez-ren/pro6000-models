#!/usr/bin/env bash

docker rm -f minimax-m2-7-fp8

docker run --device "nvidia.com/gpu=all" \
  --name minimax-m2-7-fp8 \
  -d \
  --shm-size 16g \
  -p 8000:8000 \
  -v /root/.cache/huggingface:/root/.cache/huggingface \
  voipmonitor/sglang:cu130 \
  python -m sglang.launch_server \
    --model lukealonso/MiniMax-M2.7-NVFP4 \
    --reasoning-parser minimax \
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

docker logs -f minimax-m2-7-fp8
