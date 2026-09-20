@echo off
setlocal
cd /d "%~dp0"
call config.bat

if not exist quantus-miner.exe (
  powershell -NoProfile -Command "Invoke-WebRequest -Uri 'https://github.com/Quantus-Network/quantus-miner/releases/download/v4.2.0/quantus-miner-windows-x86_64.exe' -OutFile 'quantus-miner.exe'"
)

powershell -NoProfile -Command "Invoke-WebRequest -Uri '%POOL_API%/api/tls-pin' -OutFile 'pin.txt'"
echo %PAYOUT_ADDRESS%.%WORKER_NAME%> addr.txt

set NODE_ADDR=%POOL_IP%:%POOL_PORT%
echo CPU-only mining -^> %NODE_ADDR% as %PAYOUT_ADDRESS%.%WORKER_NAME%
quantus-miner.exe serve --node-addr %NODE_ADDR% --auth-token-file addr.txt --tls-cert-sha256-file pin.txt --cpu-workers %CPU_WORKERS% --gpu-devices 0 --metrics-port 9900 -v
echo.
echo Miner exited with code %ERRORLEVEL%
pause
