#!/usr/bin/env bash
# CPU-only fallback — use if GPU mode Aborts (core dumped).
set -euo pipefail
cd "$(dirname "$0")"
# shellcheck disable=SC1091
source ./config.env

POOL_IP=${POOL_IP:-40.160.89.50}
NODE_ADDR="${POOL_IP}:${POOL_PORT}"

[[ -x ./quantus-miner ]] || {
  curl -fsSL -o quantus-miner https://github.com/Quantus-Network/quantus-miner/releases/download/v4.2.0/quantus-miner-linux-x86_64
  chmod +x quantus-miner
}
curl -fsSL "${POOL_API}/api/tls-pin" | tr -d '\n' > pin.txt
echo >> pin.txt
echo "${PAYOUT_ADDRESS}.${WORKER_NAME}" > addr.txt

echo "CPU-only mining -> ${NODE_ADDR} as $(cat addr.txt)"
exec ./quantus-miner serve \
  --node-addr "$NODE_ADDR" \
  --auth-token-file addr.txt \
  --tls-cert-sha256-file pin.txt \
  --cpu-workers "${CPU_WORKERS:-16}" \
  --gpu-devices 0 \
  --metrics-port 9900 \
  -v
