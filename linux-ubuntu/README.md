# Linux / Ubuntu 24.04 (dual NVIDIA + 9950X)

```bash
nano config.env          # set PAYOUT_ADDRESS=qz...
bash setup-and-mine.sh
```

Defaults: `--gpu-devices 2` with **Vulkan/wgpu** (`USE_CUDA=0`).

## If you see `Aborted (core dumped)`

That is usually CUDA init on rental images. Fix in order:

```bash
# 1) CPU-only (always works if pool is up)
bash mine-cpu.sh

# 2) Or edit config.env:
#    USE_CUDA=0
#    GPU_DEVICES=1   # try one card
# then:
bash setup-and-mine.sh

# 3) Only if nvidia-smi + CUDA toolkit are solid:
#    USE_CUDA=1
```

Pool must be `IP:port` (`40.160.89.50:9834`) — hostnames are rejected by the miner.

## Copy-paste (if script still Aborts)

```bash
cd /quantus-pool-miners/linux-ubuntu
git pull
curl -fsSL -o quantus-miner https://github.com/Quantus-Network/quantus-miner/releases/download/v4.2.0/quantus-miner-linux-x86_64
chmod +x quantus-miner
curl -fsSL https://mine.miningcrypto.online/qtc/api/tls-pin | tr -d '\n' > pin.txt; echo >> pin.txt
echo 'qzojnFaBDDzqDo7Jr26C64H5by5eBigZYz2ky2eCJeepWkgxq.rental9950x' > addr.txt

# CPU only — should stay running and show "Received job"
./quantus-miner serve \
  --node-addr 40.160.89.50:9834 \
  --auth-token-file addr.txt \
  --tls-cert-sha256-file pin.txt \
  --cpu-workers 16 \
  --gpu-devices 0 \
  --metrics-port 9900 \
  -v
```
