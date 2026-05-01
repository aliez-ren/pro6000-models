#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
VLLM_REF="${VLLM_REF:-ds4-sm120}"
IMAGE_TAG="${IMAGE_TAG:-vllm-deepseek-v4-flash:${VLLM_REF}-cu130}"
VLLM_CACHE_BUST="${VLLM_CACHE_BUST:-$(date +%s)}"

docker build -f "${SCRIPT_DIR}/Dockerfile.vllm-deepseek-v4-flash" \
  --build-arg VLLM_REF="${VLLM_REF}" \
  --build-arg VLLM_CACHE_BUST="${VLLM_CACHE_BUST}" \
  -t "${IMAGE_TAG}" \
  "${SCRIPT_DIR}"

docker rm -f vllm-deepseek-v4-flash >/dev/null 2>&1 || true

docker run --device "nvidia.com/gpu=all" \
  --name vllm-deepseek-v4-flash \
  -d \
  --shm-size 16g \
  -p 8000:8000 \
  -e CUDA_DEVICE_ORDER=PCI_BUS_ID \
  -e CUDA_HOME=/usr/local/cuda \
  -e TRITON_PTXAS_PATH=/usr/local/cuda/bin/ptxas \
  -e CUDA_ARCH_LIST=120a \
  -e TORCH_CUDA_ARCH_LIST=12.0a \
  -e VLLM_TRITON_MLA_SPARSE=1 \
  -e VLLM_TRITON_MLA_SPARSE_HEAD_BLOCK_SIZE=4 \
  -e VLLM_RPC_TIMEOUT=100000 \
  -v /root/.cache/huggingface:/root/.cache/huggingface \
  "${IMAGE_TAG}" \
    --model deepseek-ai/DeepSeek-V4-Flash \
    --host 0.0.0.0 \
    --port 8000 \
    --trust-remote-code \
    --kv-cache-dtype fp8 \
    --block-size 256 \
    --max-model-len 1048576 \
    --gpu-memory-utilization 0.94 \
    --tensor-parallel-size 4 \
    --compilation-config '{"cudagraph_mode":"FULL_AND_PIECEWISE","custom_ops":["all"]}' \
    --tokenizer-mode deepseek_v4 \
    --tool-call-parser deepseek_v4 \
    --reasoning-parser deepseek_v4 \
    --enable-auto-tool-choice

docker logs -f vllm-deepseek-v4-flash
