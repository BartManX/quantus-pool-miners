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
