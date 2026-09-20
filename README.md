# MiningCrypto Quantus (QTC) miner configs

Ready-to-run configs for the [MiningCrypto QTC pool](https://mine.miningcrypto.online/qtc/api/pool).

| Folder | Hardware target |
|--------|-----------------|
| `linux-ubuntu/` | Ubuntu 24.04 — RTX 3070 Laptop + RTX 3060 Ti + Ryzen 9 9950X |
| `windows/` | Windows 11 — RTX 3060 12GB + Ryzen 9 5950X |

## Pool

- Miner: `mine.miningcrypto.online:9834` (UDP / QUIC)
- API: https://mine.miningcrypto.online/qtc/api/pool
- Fee: 1% PPLNS
- Miner software: [quantus-miner v4.2.0+](https://github.com/Quantus-Network/quantus-miner/releases)

## Quick start

1. Set your `qz…` payout address in `config.env` (Linux) or `config.bat` (Windows).
2. Run `setup-and-mine.sh` or `setup-and-mine.bat`.

Scripts download the official miner binary and the pool TLS pin automatically.
