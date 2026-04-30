#!/usr/bin/env bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

docker build -f "${SCRIPT_DIR}/Dockerfile.sglang-glm5-reap-nvfp4" \
  -t sglang-glm5-reap-nvfp4:cu130 \
  "${SCRIPT_DIR}"

docker rm -f sglang-glm5-reap-nvfp4

docker run --device "nvidia.com/gpu=all" \
  --name sglang-glm5-reap-nvfp4 \
  -d \
  --shm-size 16g \
  --ulimit memlock=-1 \
  --ulimit stack=67108864 \
  -p 8000:8000 \
  -e MODEL_PATH=/root/.cache/huggingface/hub/models--0xSero--GLM-5.1-478B-A42B-REAP-NVFP4/snapshots/531009d551845b10482a19c03fc9eabf6f7d38b9 \
  -v /root/.cache/huggingface:/root/.cache/huggingface \
  -v sglang-glm5-reap-nvfp4-jit:/cache/jit \
  sglang-glm5-reap-nvfp4:cu130

docker logs -f sglang-glm5-reap-nvfp4
