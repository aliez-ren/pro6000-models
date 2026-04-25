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
    --model QuantTrio/Qwen3.5-397B-A17B-AWQ \
    --reasoning-parser qwen3 \
    --tool-call-parser qwen3_coder \
    --tensor-parallel-size 2 \
    --pipeline-parallel-size 2 \
    --trust-remote-code \
    --cuda-graph-max-bs 64 \
    --max-running-requests 64 \
    --chunked-prefill-size 16384 \
    --mem-fraction-static 0.93 \
    --host 0.0.0.0 \
    --port 8000 \
    --attention-backend flashinfer \
    --enable-pcie-oneshot-allreduce \
    --sleep-on-idle \
    --mamba-scheduler-strategy extra_buffer

docker logs -f sglang-qwen3-5-397b-a17b-nvfp4
