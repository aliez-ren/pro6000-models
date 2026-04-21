#!/usr/bin/env bash

docker rm -f vllm-qwen3-5-397b-a17b-nvfp4

docker run --device "nvidia.com/gpu=all" \
  --name vllm-qwen3-5-397b-a17b-nvfp4 \
  -d \
  --shm-size 16g \
  -p 8000:8000 \
  -e VLLM_USE_FLASHINFER_MOE_MXFP4_MXFP8_CUTLASS=1 \
  -v ~/.cache/huggingface:/root/.cache/huggingface \
  vllm/vllm-openai:cu130-nightly \
    --model nvidia/Qwen3.5-397B-A17B-NVFP4 \
    --async-scheduling \
    --tensor-parallel-size 2 \
    --pipeline-parallel-size 2 \
    --data-parallel-size 1 \
    --trust-remote-code \
    --attention-backend TRITON_ATTN \
    --gpu-memory-utilization 0.95 \
    --max-cudagraph-capture-size 64 \
    --enable-chunked-prefill \
    --enable-prefix-caching \
    --language-model-only \
    --host 0.0.0.0 \
    --port 8000 \
    --enable-auto-tool-choice \
    --tool-call-parser qwen3_coder \
    --reasoning-parser qwen3

docker logs -f vllm-qwen3-5-397b-a17b-nvfp4
