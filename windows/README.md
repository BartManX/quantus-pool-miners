# Quantus — Windows 11 (RTX 3060 12GB + Ryzen 9 5950X)

1. Copy this folder to the Windows box.
2. Edit `config.bat` → set `PAYOUT_ADDRESS` to your `qz…` wallet address.
3. Optional: double-click `benchmark.bat` (CUDA smoke test).
4. Double-click `setup-and-mine.bat`.

Pool: `mine.miningcrypto.online:9834` (UDP/QUIC)  
API: https://mine.miningcrypto.online/qtc/api/pool  

Defaults: `--cuda-gpu --gpu-devices 1 --cpu-workers 8`. Set `CPU_WORKERS=0` in `config.bat` for GPU-only.

Needs current NVIDIA drivers (`nvidia-smi` works in Command Prompt).
