#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
IMAGE_NAME="${IMAGE_NAME:-sglang-glm5-reap-nvfp4:cu129}"
CONTAINER_NAME="${CONTAINER_NAME:-sglang-glm5-reap-nvfp4}"
HOST_PORT="${HOST_PORT:-8000}"
MODEL_PATH="${MODEL_PATH:-/root/.cache/huggingface/hub/models--0xSero--GLM-5.1-478B-A42B-REAP-NVFP4/snapshots/4a1dc5dae9158b68e3a7f5bd5dc009d409da55ad}"
HF_CACHE_ROOT="${HF_CACHE_ROOT:-/root/.cache/huggingface}"

if ! docker image inspect "${IMAGE_NAME}" >/dev/null 2>&1; then
  docker build -f "${SCRIPT_DIR}/Dockerfile.sglang-glm5-reap-nvfp4" -t "${IMAGE_NAME}" "${SCRIPT_DIR}"
fi

docker rm -f "${CONTAINER_NAME}" >/dev/null 2>&1 || true

docker run --device "nvidia.com/gpu=all" \
  --name "${CONTAINER_NAME}" \
  -d \
  --shm-size 16g \
  --ulimit memlock=-1 \
  --ulimit stack=67108864 \
  -p "${HOST_PORT}:8000" \
  -e MODEL_PATH="${MODEL_PATH}" \
  -v "${HF_CACHE_ROOT}:${HF_CACHE_ROOT}" \
  "${IMAGE_NAME}"

docker logs -f "${CONTAINER_NAME}"
