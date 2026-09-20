@echo off
setlocal EnableExtensions
cd /d "%~dp0"

call config.bat

if "%PAYOUT_ADDRESS%"=="PASTE_YOUR_QZK_ADDRESS_HERE" (
  echo Edit config.bat and set PAYOUT_ADDRESS to your Quantus qz... address.
  exit /b 1
)
echo %PAYOUT_ADDRESS%| findstr /b "qz" >nul
if errorlevel 1 (
  echo PAYOUT_ADDRESS should start with qz
  exit /b 1
)

where nvidia-smi >nul 2>&1
if errorlevel 1 (
  echo nvidia-smi not found. Install/update NVIDIA Game Ready or Studio drivers.
  exit /b 1
)
echo ==^> GPUs
nvidia-smi -L

if not exist quantus-miner.exe (
  echo ==^> Downloading quantus-miner v4.2.0
  powershell -NoProfile -Command ^
    "Invoke-WebRequest -Uri 'https://github.com/Quantus-Network/quantus-miner/releases/download/v4.2.0/quantus-miner-windows-x86_64.exe' -OutFile 'quantus-miner.exe'"
  if errorlevel 1 (
    echo Download failed.
    exit /b 1
  )
)

echo ==^> Fetching pool TLS pin
powershell -NoProfile -Command ^
  "Invoke-WebRequest -Uri '%POOL_API%/api/tls-pin' -OutFile 'pin.txt'"
echo %PAYOUT_ADDRESS%.%WORKER_NAME%> addr.txt

echo ==^> Pool status
powershell -NoProfile -Command ^
  "try { (Invoke-RestMethod '%POOL_API%/api/pool') | Select-Object current_job_id,network_difficulty,connected_miners | Format-List } catch { $_.Exception.Message }"

set CUDA_FLAG=
if "%USE_CUDA%"=="1" set CUDA_FLAG=--cuda-gpu

echo ==^> Starting miner: GPUs=%GPU_DEVICES% CUDA=%USE_CUDA% CPU=%CPU_WORKERS%
echo     auth=%PAYOUT_ADDRESS%.%WORKER_NAME%  pool=%POOL_HOST%:%POOL_PORT%
quantus-miner.exe serve --node-addr %POOL_HOST%:%POOL_PORT% --auth-token-file addr.txt --tls-cert-sha256-file pin.txt --gpu-devices %GPU_DEVICES% --cpu-workers %CPU_WORKERS% %CUDA_FLAG% --metrics-port 9900 -v
