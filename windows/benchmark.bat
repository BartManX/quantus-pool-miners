@echo off
setlocal
cd /d "%~dp0"
call config.bat
if not exist quantus-miner.exe (
  powershell -NoProfile -Command "Invoke-WebRequest -Uri 'https://github.com/Quantus-Network/quantus-miner/releases/download/v4.2.0/quantus-miner-windows-x86_64.exe' -OutFile 'quantus-miner.exe'"
)
nvidia-smi -L
quantus-miner.exe benchmark --cuda-gpu --gpu-devices %GPU_DEVICES% --cpu-workers 0 --duration 10
pause
