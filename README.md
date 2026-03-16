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
