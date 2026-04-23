#!/usr/bin/env bash

docker rm -f qwen3-5-397b-a17b-nvfp4

docker run --device "nvidia.com/gpu=all"  \
  --ipc=host --shm-size=8g --network=host \
  -v ~/.cache/huggingface:/root/.cache/huggingface \
  -v jit-cache:/cache/jit \
  -e NCCL_P2P_LEVEL=SYS \
  -e SGLANG_ENABLE_SPEC_V2=True \
  voipmonitor/sglang:cu130 \
  python3 -m sglang.launch_server \
    --model nvidia/Qwen3.5-397B-A17B-NVFP4 \
    --served-model-name Qwen3.5 \
    --reasoning-parser qwen3 --tool-call-parser qwen3_coder \
    --tensor-parallel-size 4 \
    --quantization modelopt_fp4 --kv-cache-dtype fp8_e4m3 \
    --trust-remote-code \
    --cuda-graph-max-bs 64 --max-running-requests 64 \
    --mem-fraction-static 0.93 --chunked-prefill-size 16384 \
    --host 0.0.0.0 --port 8000 \
    --attention-backend flashinfer \
    --fp4-gemm-backend b12x --moe-runner-backend b12x \
    --enable-pcie-oneshot-allreduce \
    --sleep-on-idle \
    --mamba-scheduler-strategy extra_buffer \
    --speculative-algo NEXTN --speculative-num-steps 4 \
    --speculative-eagle-topk 1 --speculative-num-draft-tokens 6

docker logs -f qwen3-5-397b-a17b-nvfp4
