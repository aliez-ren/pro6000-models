# RTX PRO 6000 LLM models

```bash
llama-benchy --base-url http://localhost:8000/v1 --model nvidia/NVIDIA-Nemotron-3-Super-120B-A12B-NVFP4 --depth 2048 8192 32768
```
| model                                          |            test |                t/s |     peak t/s |         ttfr (ms) |      est_ppt (ms) |     e2e_ttft (ms) |
|:-----------------------------------------------|----------------:|-------------------:|-------------:|------------------:|------------------:|------------------:|
| nvidia/NVIDIA-Nemotron-3-Super-120B-A12B-NVFP4 |  pp2048 @ d2048 | 10624.08 ± 5870.17 |              |   776.32 ± 700.59 |   772.62 ± 700.59 |   776.48 ± 700.60 |
| nvidia/NVIDIA-Nemotron-3-Super-120B-A12B-NVFP4 |    tg32 @ d2048 |       85.08 ± 0.54 | 87.89 ± 0.56 |                   |                   |                   |
| nvidia/NVIDIA-Nemotron-3-Super-120B-A12B-NVFP4 |  pp2048 @ d8192 |  9938.46 ± 6288.20 |              | 3742.17 ± 4280.26 | 3738.47 ± 4280.26 | 3742.34 ± 4280.25 |
| nvidia/NVIDIA-Nemotron-3-Super-120B-A12B-NVFP4 |    tg32 @ d8192 |       84.57 ± 0.20 | 87.35 ± 0.21 |                   |                   |                   |
| nvidia/NVIDIA-Nemotron-3-Super-120B-A12B-NVFP4 | pp2048 @ d32768 |  12390.65 ± 161.59 |              |   2814.04 ± 36.99 |   2810.34 ± 36.99 |   2814.25 ± 36.99 |
| nvidia/NVIDIA-Nemotron-3-Super-120B-A12B-NVFP4 |   tg32 @ d32768 |       82.29 ± 1.01 | 84.99 ± 1.04 |                   |                   |                   |

```bash
llama-benchy --base-url http://localhost:8000/v1 --model AxionML/Qwen3.5-122B-A10B-NVFP4 --depth 2048 8192 32768
```
| model                           |            test |                t/s |      peak t/s |       ttfr (ms) |    est_ppt (ms) |   e2e_ttft (ms) |
|:--------------------------------|----------------:|-------------------:|--------------:|----------------:|----------------:|----------------:|
| AxionML/Qwen3.5-122B-A10B-NVFP4 |  pp2048 @ d2048 | 13312.36 ± 4746.51 |               | 376.22 ± 176.17 | 370.51 ± 176.17 | 376.45 ± 176.24 |
| AxionML/Qwen3.5-122B-A10B-NVFP4 |    tg32 @ d2048 |      107.81 ± 0.71 | 111.38 ± 0.73 |                 |                 |                 |
| AxionML/Qwen3.5-122B-A10B-NVFP4 |  pp2048 @ d8192 | 14761.63 ± 1415.07 |               |  706.35 ± 72.01 |  700.64 ± 72.01 |  706.50 ± 72.01 |
| AxionML/Qwen3.5-122B-A10B-NVFP4 |    tg32 @ d8192 |      104.81 ± 0.39 | 108.28 ± 0.41 |                 |                 |                 |
| AxionML/Qwen3.5-122B-A10B-NVFP4 | pp2048 @ d32768 |   9425.39 ± 106.71 |               | 3700.14 ± 42.15 | 3694.44 ± 42.15 | 3700.30 ± 42.15 |
| AxionML/Qwen3.5-122B-A10B-NVFP4 |   tg32 @ d32768 |       95.05 ± 0.14 |  98.17 ± 0.14 |                 |                 |                 |

```bash
llama-benchy --base-url http://localhost:8000/v1 --model openai/gpt-oss-120b --depth 2048 8192 32768
```
| model               |            test |               t/s |       peak t/s |       ttfr (ms) |    est_ppt (ms) |   e2e_ttft (ms) |
|:--------------------|----------------:|------------------:|---------------:|----------------:|----------------:|----------------:|
| openai/gpt-oss-120b |  pp2048 @ d2048 | 20656.53 ± 857.35 |                |   204.05 ± 8.46 |   198.64 ± 8.46 |   216.34 ± 8.32 |
| openai/gpt-oss-120b |    tg32 @ d2048 |    184.87 ± 13.81 | 191.64 ± 14.36 |                 |                 |                 |
| openai/gpt-oss-120b |  pp2048 @ d8192 |  17939.87 ± 71.16 |                |   576.21 ± 2.26 |   570.80 ± 2.26 |   588.22 ± 1.77 |
| openai/gpt-oss-120b |    tg32 @ d8192 |     178.61 ± 1.09 |  185.23 ± 1.12 |                 |                 |                 |
| openai/gpt-oss-120b | pp2048 @ d32768 | 10480.27 ± 117.64 |                | 3327.88 ± 37.57 | 3322.47 ± 37.57 | 3336.23 ± 37.60 |
| openai/gpt-oss-120b |   tg32 @ d32768 |     143.40 ± 0.38 |  148.70 ± 0.38 |                 |                 |                 |


```bash
llama-benchy --base-url http://localhost:8000/v1 --model mistralai/Mistral-Small-4-119B-2603-NVFP4 --depth 2048 8192 32768
```
| model                                     |            test |                t/s |     peak t/s |         ttfr (ms) |      est_ppt (ms) |     e2e_ttft (ms) |
|:------------------------------------------|----------------:|-------------------:|-------------:|------------------:|------------------:|------------------:|
| mistralai/Mistral-Small-4-119B-2603-NVFP4 |  pp2048 @ d2048 | 27344.40 ± 7338.17 |              |    172.17 ± 54.45 |    164.40 ± 54.45 |    172.36 ± 54.50 |
| mistralai/Mistral-Small-4-119B-2603-NVFP4 |    tg32 @ d2048 |       96.18 ± 2.28 | 99.31 ± 2.35 |                   |                   |                   |
| mistralai/Mistral-Small-4-119B-2603-NVFP4 |  pp2048 @ d8192 |  30849.05 ± 129.30 |              |     339.71 ± 1.39 |     331.94 ± 1.39 |     339.90 ± 1.39 |
| mistralai/Mistral-Small-4-119B-2603-NVFP4 |    tg32 @ d8192 |       89.90 ± 0.28 | 92.86 ± 0.29 |                   |                   |                   |
| mistralai/Mistral-Small-4-119B-2603-NVFP4 | pp2048 @ d32768 | 12668.60 ± 7560.97 |              | 7168.69 ± 7393.87 | 7160.93 ± 7393.87 | 7168.86 ± 7393.85 |
| mistralai/Mistral-Small-4-119B-2603-NVFP4 |   tg32 @ d32768 |       40.41 ± 2.97 | 47.06 ± 5.73 |                   |                   |                   |
