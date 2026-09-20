#!/usr/bin/env bash
# Optional: quick 10s CUDA benchmark before pointing at the pool.
set -euo pipefail
cd "$(dirname "$0")"
source ./config.env
[[ -x ./quantus-miner ]] || { curl -fsSL -o quantus-miner https://github.com/Quantus-Network/quantus-miner/releases/download/v4.2.0/quantus-miner-linux-x86_64; chmod +x quantus-miner; }
nvidia-smi -L
./quantus-miner benchmark --cuda-gpu --gpu-devices "${GPU_DEVICES}" --cpu-workers 0 --duration 10
