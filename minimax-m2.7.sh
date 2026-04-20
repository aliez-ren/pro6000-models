#!/usr/bin/env bash

docker rm -f minimax-m2-7-fp8

docker run --device "nvidia.com/gpu=all" \
  --name minimax-m2-7-fp8 \
  -d \
  --shm-size 16g \
  -p 8000:8000 \
  -e SAFETENSORS_FAST_GPU=1 \
  -v /root/.cache/huggingface:/root/.cache/huggingface \
  vllm/vllm-openai:cu130-nightly \
    --model MiniMaxAI/MiniMax-M2.7 \
    --tensor-parallel-size 2 \
    --pipeline-parallel-size 2 \
    --trust-remote-code \
    --host 0.0.0.0 \
    --port 8000 \
    --enable-auto-tool-choice \
    --tool-call-parser minimax_m2 \
    --reasoning-parser minimax_m2_append_think

docker logs -f minimax-m2-7-fp8
