#!/usr/bin/env bash

docker rm -f vllm-mistral-small-4-119b

docker run --device "nvidia.com/gpu=all" \
  --name vllm-mistral-small-4-119b \
  -d \
  --shm-size 16g \
  -p 8000:8000 \
  -v ~/.cache/huggingface:/root/.cache/huggingface \
  mistralllm/vllm-ms4:latest \
    --model mistralai/Mistral-Small-4-119B-2603-NVFP4 \
    --async-scheduling \
    --tensor-parallel-size 1 \
    --pipeline-parallel-size 1 \
    --data-parallel-size 1 \
    --trust-remote-code \
    --attention-backend TRITON_MLA \
    --gpu-memory-utilization 0.95 \
    --max-model-len 262144 \
    --max-num-batched-tokens 16384 \
    --max-num-seqs 128 \
    --enable-chunked-prefill \
    --enable-prefix-caching \
    --host 0.0.0.0 \
    --port 8000 \
    --enable-auto-tool-choice \
    --tool-call-parser mistral \
    --reasoning-parser mistral

docker logs -f vllm-mistral-small-4-119b
