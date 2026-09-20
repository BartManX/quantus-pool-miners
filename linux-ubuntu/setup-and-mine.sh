#!/usr/bin/env bash
# Quantus miner setup + start for dual-NVIDIA Ubuntu rentals (CUDA).
set -euo pipefail
cd "$(dirname "$0")"

# shellcheck disable=SC1091
source ./config.env

if [[ "$PAYOUT_ADDRESS" == "PASTE_YOUR_QZK_ADDRESS_HERE" || -z "$PAYOUT_ADDRESS" ]]; then
  echo "Edit config.env and set PAYOUT_ADDRESS to your Quantus qz… address." >&2
  exit 1
fi
if [[ ! "$PAYOUT_ADDRESS" =~ ^qz ]]; then
  echo "PAYOUT_ADDRESS should start with qz" >&2
  exit 1
fi

echo "==> Checking NVIDIA / CUDA"
if ! command -v nvidia-smi >/dev/null; then
  echo "nvidia-smi not found. Install NVIDIA drivers on this rental first." >&2
  exit 1
fi
nvidia-smi -L
GPU_COUNT=$(nvidia-smi -L | wc -l)
if (( GPU_COUNT < GPU_DEVICES )); then
  echo "Only $GPU_COUNT GPU(s) visible; lowering GPU_DEVICES to match."
  GPU_DEVICES=$GPU_COUNT
fi

MINER_VER="v4.2.0"
MINER_URL="https://github.com/Quantus-Network/quantus-miner/releases/download/${MINER_VER}/quantus-miner-linux-x86_64"
if [[ ! -x ./quantus-miner ]]; then
  echo "==> Downloading quantus-miner ${MINER_VER}"
  curl -fsSL -o quantus-miner "$MINER_URL"
  chmod +x quantus-miner
fi

# Resolve hostname -> IP if POOL_IP unset (miner SocketAddr rejects DNS names)
if [[ -z "${POOL_IP:-}" ]]; then
  POOL_IP=$(getent ahostsv4 mine.miningcrypto.online 2>/dev/null | awk '{print $1; exit}')
  POOL_IP=${POOL_IP:-40.160.89.50}
fi
NODE_ADDR="${POOL_IP}:${POOL_PORT}"

echo "==> Fetching pool TLS pin"
curl -fsSL "${POOL_API}/api/tls-pin" | tr -d '\n' > pin.txt
echo >> pin.txt
echo "${PAYOUT_ADDRESS}.${WORKER_NAME}" > addr.txt

echo "==> Pool status"
if command -v python3 >/dev/null; then
  curl -fsSL "${POOL_API}/api/pool" | python3 -c 'import sys,json; d=json.load(sys.stdin); print("job:", d.get("current_job_id"), "diff:", d.get("network_difficulty"), "miners:", d.get("connected_miners"))' || true
else
  curl -fsSL "${POOL_API}/api/pool" || true
  echo
fi

ARGS=(
  serve
  --node-addr "$NODE_ADDR"
  --auth-token-file addr.txt
  --tls-cert-sha256-file pin.txt
  --gpu-devices "$GPU_DEVICES"
  --cpu-workers "$CPU_WORKERS"
  --metrics-port 9900
  -v
)
if [[ "${USE_CUDA}" == "1" ]]; then
  ARGS+=(--cuda-gpu)
fi

echo "==> Starting miner: GPUs=${GPU_DEVICES} CUDA=${USE_CUDA} CPU=${CPU_WORKERS}"
echo "    auth=$(cat addr.txt)  pool=${NODE_ADDR}"
exec ./quantus-miner "${ARGS[@]}"
