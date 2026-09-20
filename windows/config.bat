@REM Quantus mining — Windows 11
@REM Hardware: RTX 3060 12GB + Ryzen 9 5950X
@REM
@REM 1) Edit PAYOUT_ADDRESS below (your qz… address from the Quantus wallet)
@REM 2) Run setup-and-mine.bat

set PAYOUT_ADDRESS=PASTE_YOUR_QZK_ADDRESS_HERE
set WORKER_NAME=win5950x

@REM Miner requires IP:port (not a hostname)
set POOL_IP=40.160.89.50
set POOL_PORT=9834
set POOL_API=https://mine.miningcrypto.online/qtc

@REM 1 CUDA GPU; light CPU assist from the 5950X (set CPU_WORKERS=0 for GPU-only)
set GPU_DEVICES=1
set CPU_WORKERS=8
set USE_CUDA=1
