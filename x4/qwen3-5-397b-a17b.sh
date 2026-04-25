#!/usr/bin/env bash

docker rm -f sglang-qwen3-5-397b-a17b-nvfp4

docker run --device "nvidia.com/gpu=all"  \
  --name sglang-qwen3-5-397b-a17b-nvfp4 \
  --ipc=host --shm-size=8g --network=host \
  -d \
  -v /root/.cache/huggingface:/root/.cache/huggingface \
  -v jit-cache:/cache/jit \
  -e SGLANG_ENABLE_SPEC_V2=True \
  voipmonitor/sglang:cu130 \
  python3 -m sglang.launch_server \
    --model nvidia/Qwen3.5-397B-A17B-NVFP4 \
    --reasoning-parser qwen3 \
    --tool-call-parser qwen3_coder \
    --tensor-parallel-size 2 \
    --pipeline-parallel-size 2 \
    --quantization modelopt_fp4 \
    --kv-cache-dtype fp8_e4m3 \
    --trust-remote-code \
    --cuda-graph-max-bs 64 \
    --max-running-requests 64 \
    --chunked-prefill-size 16384 \
    --mamba-scheduler-strategy extra_buffer \
    --mem-fraction-static 0.93 \
    --host 0.0.0.0 \
    --port 8000 \
    --schedule-conservativeness 0.1 \
    --attention-backend flashinfer \
    --fp4-gemm-backend b12x \
    --moe-runner-backend b12x \
    --sleep-on-idle

docker logs -f sglang-qwen3-5-397b-a17b-nvfp4
