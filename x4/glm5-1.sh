#!/usr/bin/env bash

docker rm -f sglang-glm5-1-nvfp4

docker run --device "nvidia.com/gpu=all" \
  --name sglang-glm5-1-nvfp4 \
  -d \
  --shm-size 16g \
  -p 30000:30000 \
  -e PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True \
  -v /root/.cache/huggingface:/root/.cache/huggingface \
  voipmonitor/sglang:cu130 \
    python -m sglang.launch_server \
    --model lukealonso/GLM-5.1-NVFP4 \
    --reasoning-parser glm45 \
    --tool-call-parser glm47 \
    --tp 4 \
    --trust-remote-code \
    --quantization modelopt_fp4 \
    --kv-cache-dtype bf16 \
    --fp4-gemm-backend b12x \
    --attention-backend flashinfer \
    --moe-runner-backend b12x \
    --disable-shared-experts-fusion \
    --mem-fraction-static 0.88 \
    --context-length 16384 \
    --chunked-prefill-size 512 \
    --max-prefill-tokens 512 \
    --nsa-prefill-backend fa3 \
    --cpu-offload-gb 0 \
    --offload-group-size 78 \
    --offload-num-in-group 30 \
    --offload-prefetch-step 1 \
    --offload-mode cpu \
    --max-running-requests 1 \
    --disable-cuda-graph \
    --host 0.0.0.0

docker logs -f sglang-glm5-1-nvfp4
