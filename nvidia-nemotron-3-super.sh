#!/usr/bin/env bash

docker rm -f vllm-nvidia-nemotron-3-super

docker run --device "nvidia.com/gpu=all" \
  --name vllm-nvidia-nemotron-3-super \
  -d \
  --shm-size 16g \
  -p 8000:8000 \
  -e VLLM_NVFP4_GEMM_BACKEND=marlin \
  -e VLLM_NVFP4_MOE_BACKEND=MARLIN \
  -v ~/.cache/huggingface:/root/.cache/huggingface \
  vllm/vllm-openai:v0.17.1-cu130 \
    --model nvidia/NVIDIA-Nemotron-3-Super-120B-A12B-NVFP4 \
    --async-scheduling \
    --tensor-parallel-size 1 \
    --pipeline-parallel-size 1 \
    --data-parallel-size 1 \
    --swap-space 0 \
    --trust-remote-code \
    --attention-backend TRITON_ATTN \
    --gpu-memory-utilization 0.9 \
    --enable-chunked-prefill \
    --host 0.0.0.0 \
    --port 8000 \
    --enable-auto-tool-choice \
    --tool-call-parser qwen3_coder \
    --reasoning-parser-plugin "/root/.cache/huggingface/hub/models--nvidia--NVIDIA-Nemotron-3-Super-120B-A12B-NVFP4/snapshots/167959da964ab08b30211f71e68f6670eaa87966/super_v3_reasoning_parser.py" \
    --reasoning-parser super_v3

docker logs -f vllm-nvidia-nemotron-3-super
