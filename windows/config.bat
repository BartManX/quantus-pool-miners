@REM Quantus mining — Windows 11 (RTX 3060 12GB + Ryzen 9 5950X)
@REM Edit PAYOUT_ADDRESS then run setup-and-mine.bat

set PAYOUT_ADDRESS=PASTE_YOUR_QZK_ADDRESS_HERE
set WORKER_NAME=win5950x

@REM Miner requires IP:port (not a hostname)
set POOL_IP=40.160.89.50
set POOL_PORT=9834
set POOL_API=https://mine.miningcrypto.online/qtc

set GPU_DEVICES=1
set CPU_WORKERS=8

@REM USE_CUDA=1 often exits immediately on Windows without a matching CUDA toolkit.
@REM Leave 0 (Vulkan/wgpu). Set to 1 only after mine-cpu.bat works.
set USE_CUDA=0
