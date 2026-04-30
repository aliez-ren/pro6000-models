#!/usr/bin/env bash
set -euo pipefail

MODEL_PATH="${MODEL_PATH:-/root/.cache/huggingface/hub/models--0xSero--GLM-5.1-478B-A42B-REAP-NVFP4/snapshots/531009d551845b10482a19c03fc9eabf6f7d38b9}"
SERVED_MODEL_NAME="${SERVED_MODEL_NAME:-GLM-5.1-478B-A42B-REAP-NVFP4}"
HOST="${HOST:-0.0.0.0}"
PORT="${PORT:-8000}"
CHAT_TEMPLATE="${CHAT_TEMPLATE:-${MODEL_PATH}/chat_template.jinja}"

export CUDA_DEVICE_ORDER="${CUDA_DEVICE_ORDER:-PCI_BUS_ID}"
export CUDA_VISIBLE_DEVICES="${CUDA_VISIBLE_DEVICES:-0,1,2,3}"

# DeepGEMM has no sm_120 kernels — keep it disabled.
export SGLANG_ENABLE_JIT_DEEPGEMM="${SGLANG_ENABLE_JIT_DEEPGEMM:-0}"
export SGLANG_ENABLE_DEEP_GEMM="${SGLANG_ENABLE_DEEP_GEMM:-0}"
export SGLANG_DISABLE_DEEP_GEMM="${SGLANG_DISABLE_DEEP_GEMM:-1}"
export SGLANG_SET_CPU_AFFINITY="${SGLANG_SET_CPU_AFFINITY:-1}"
export SGLANG_ENABLE_SPEC_V2="${SGLANG_ENABLE_SPEC_V2:-True}"
export FLASHINFER_DISABLE_VERSION_CHECK="${FLASHINFER_DISABLE_VERSION_CHECK:-1}"

export OMP_NUM_THREADS="${OMP_NUM_THREADS:-8}"
export SAFETENSORS_FAST_GPU="${SAFETENSORS_FAST_GPU:-1}"

# JIT cache dirs (the voipmonitor image already defaults these to /cache/jit/*;
# re-export so users mounting custom volumes still see them.)
export TRITON_CACHE_DIR="${TRITON_CACHE_DIR:-/cache/jit/triton}"
export TORCH_EXTENSIONS_DIR="${TORCH_EXTENSIONS_DIR:-/cache/jit/torch_extensions}"
export FLASHINFER_WORKSPACE_BASE="${FLASHINFER_WORKSPACE_BASE:-/cache/jit/flashinfer}"
export TVM_FFI_CACHE_DIR="${TVM_FFI_CACHE_DIR:-/cache/jit/tvm-ffi}"
mkdir -p "${TRITON_CACHE_DIR}" "${TORCH_EXTENSIONS_DIR}" "${FLASHINFER_WORKSPACE_BASE}" "${TVM_FFI_CACHE_DIR}" || true

exec python -m sglang.launch_server \
  --model-path "${MODEL_PATH}" \
  --served-model-name "${SERVED_MODEL_NAME}" \
  --host "${HOST}" \
  --port "${PORT}" \
  --trust-remote-code \
  --tensor-parallel-size "${TENSOR_PARALLEL_SIZE:-4}" \
  --pipeline-parallel-size "${PIPELINE_PARALLEL_SIZE:-1}" \
  --context-length "${CONTEXT_LENGTH:-202752}" \
  --max-running-requests "${MAX_RUNNING_REQUESTS:-4}" \
  --mem-fraction-static "${MEM_FRACTION_STATIC:-0.94}" \
  --chunked-prefill-size "${CHUNKED_PREFILL_SIZE:-16384}" \
  --quantization "${QUANTIZATION:-modelopt_fp4}" \
  --kv-cache-dtype "${KV_CACHE_DTYPE:-bf16}" \
  --attention-backend "${ATTENTION_BACKEND:-flashinfer}" \
  --moe-runner-backend "${MOE_RUNNER_BACKEND:-b12x}" \
  --fp4-gemm-backend "${FP4_GEMM_BACKEND:-b12x}" \
  --cuda-graph-max-bs "${CUDA_GRAPH_MAX_BS:-16}" \
  --tool-call-parser "${TOOL_CALL_PARSER:-glm47}" \
  --reasoning-parser "${REASONING_PARSER:-glm45}" \
  --chat-template "${CHAT_TEMPLATE}" \
  --enable-pcie-oneshot-allreduce \
  --model-loader-extra-config '{"enable_multithread_load": true, "num_threads": 64}' \
  --json-model-override-args '{"index_topk_pattern": "FFSFSSSFSSFFFSSSFFFSFSSSSSSFFSFFSFFSSFFFFFFSFFFFFSFFSSSSSSFSFFFSFSSSFSFFSFFSSS"}' \
  "$@"
