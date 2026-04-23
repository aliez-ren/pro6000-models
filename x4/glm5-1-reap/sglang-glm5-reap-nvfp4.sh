#!/usr/bin/env bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

docker build -f "${SCRIPT_DIR}/Dockerfile.sglang-glm5-reap-nvfp4" \
  -t sglang-glm5-reap-nvfp4:cu129 \
  "${SCRIPT_DIR}"

docker rm -f sglang-glm5-reap-nvfp4

docker run --device "nvidia.com/gpu=all" \
  --name sglang-glm5-reap-nvfp4 \
  -d \
  --shm-size 16g \
  --ulimit memlock=-1 \
  --ulimit stack=67108864 \
  -p 8000:8000 \
  -e MODEL_PATH=/root/.cache/huggingface/hub/models--0xSero--GLM-5.1-478B-A42B-REAP-NVFP4/snapshots/4a1dc5dae9158b68e3a7f5bd5dc009d409da55ad \
  -v /root/.cache/huggingface:/root/.cache/huggingface \
  sglang-glm5-reap-nvfp4:cu129 \
  --tensor-parallel-size 4

docker logs -f sglang-glm5-reap-nvfp4
