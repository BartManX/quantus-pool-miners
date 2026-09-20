# Windows 11 (RTX 3060 12GB + Ryzen 9 5950X)

1. Edit `config.bat` → set `PAYOUT_ADDRESS=qz...`
2. Run `setup-and-mine.bat` (GPU via wgpu, `USE_CUDA=0`)

## If the window closes / returns to the prompt right away

`--cuda-gpu` is crashing. Use CPU-only:

```bat
mine-cpu.bat
```

Or in `config.bat` set `USE_CUDA=0` (default now) and re-run `setup-and-mine.bat`.

Pool address must be IP: `40.160.89.50:9834`.
