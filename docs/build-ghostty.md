# Build Ghostty on Ubuntu

## Requirements

- Zig: `mise use --global zig@0.13.0`
- Depencencies: `sudo apt install libgtk-4-dev libadwaita-1-dev git`
- Ruby: `mise use --global ruby@3.3.6`
- FPM: `gem install fpm`

Refer to https://ghostty.org/docs/install/build

### Build Ghostty

```shell
git clone https://github.com/ghostty-org/ghostty.git
cd ghostty
zig build -Doptimize=ReleaseFast
```

### Build DEB package

```shell
cd zig-out/
mkdir -p usr/local
mv bin share usr/local/
fpm -s dir \
  -t deb \
  -p ghostty-1.0.0-1.amd64.deb \
  --name ghostty \
  --version 1.0.0 \
  --architecture amd64 \
  --url https://ghostty.org/ \
  .
```

DEB package is now ready to install.

### Set as default terminal emulator

```shell
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/ghostty 50
sudo update-alternatives --config x-terminal-emulator
```
