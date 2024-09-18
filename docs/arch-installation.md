# Arch Installation

How to install Arch, with specifics for machines with one or more existing OSes.

## Create live USB

Flash an USB drive with the Arch installation image. I did it from GNOME, following https://wiki.archlinux.org/title/USB_flash_installation_medium#Using_GNOME_Disk_Utility

## Install Arch

- Boot from USB
- Setup WiFi:
  ```
  ip addr show
  iwctl --passphrase "<PASS>" station wlan0 connect <ESSID>
  ```
- If multi-boot, ensure partitions are dimensioned and available. Easier to create partitions at this step than with the installer.
  ```
  cfdisk /dev/nvme0n1
  ```
- Run installer with `archinstall`
- Select mirrors region
- If multi-boot, in disk configuration assign EFI partition (probably, first one) to mountpoint `/boot`.
- Select GRUB as boot method
- Create user with sudo privileges
- Select Pipewire as sound system
- Select Profile > Desktop > GNOME / i3 / Hyprland. Use defaults and if asked about fonts just choose the first option.
- Define all other settings, like timezone, accordingly.
- Install
- If multi-boot, when asked about chroot say yes and proceed with setting up GRUB.

### Set up GRUB

- Mount installation root partition: `mount /dev/nvme0n1p5 /mnt`
- Mount boot partition (EFI): `mount /dev/nvme0n1p1 /mnt/boot`
- Install grub:
  ```
  pacman -S grub efibootmgr dosfstools os-prober mtools
  grub-install --efi-directory=/mnt/boot --target=x86_64-efi --bootloader-id=grub_uefi --recheck
  grub-mkconfig -o /boot/grub/grub.cfg
  ```
- Reboot

## Configure system

### Base system

```
sudo pacman -S --needed base-devel git
sudo pacman -S bash-completion man-db \
  openssh \
  net-tools
```

## AUR with yay

```
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

### System upgrades

Install and enable arch-update for semi-automatic system upgrades:

```
yay -S arch-update
systemctl --user enable --now arch-update-tray.service
systemctl --user enable --now arch-update.timer
```

### Bluetooth

```
sudo systemctl start bluetooth
sudo systemctl enable bluetooth
sudo pacman -S pipewire-pulse
```

In case of using a window manager instead of GNOME:

```
sudo pacman -S bluez bluez-utils blueman
```

More info: https://itsfoss.com/bluetooth-arch-linux/

### Desktop Apps

```
sudo pacman -S firefox \
  flameshot \
  rofi \
  vlc
```

```
yay -S brave-bin \
  dropbox \
  slack-desktop \
  spotify
```

### Editors

```
sudo pacman -S neovim
sudo yay -S visual-studio-code-bin
```

### Development Tools

```
yay -S mise-bin
```

### Shell

```
sudo pacman -S alacritty kitty \
  bat \
  fzf \
  tmux
```

### GNOME

```
sudo pacman -S gnome-themes-extra
sudo pacman -S xclip
yay -S adwaita-qt5-git adwaita-qt6-git
yay -S numix-circle-icon-theme-git
```

Install Adwaita One Dark theme for GNOME following instructions from https://www.gnome-look.org/p/1827585. Restart or logout/login.

Configure nautilus as default app for opening directories with `xdg-open`:

```
xdg-mime default org.gnome.Nautilus.desktop inode/directory
```

Configure flameshot keyboard shortcut (Ctrl + Alt + S) with command: `script --command "flameshot gui" /dev/null` (more info https://github.com/flameshot-org/flameshot/issues/3365)

#### Use Ubuntu font in GNOME:

```
sudo pacman -S ttf-ubuntu-font-family
```

Set it up with GNOME Tweaks, use `Ubuntu Regular` for interface and document. Use `Ubuntu Mono Regular` for source code. Replaces `Cantarell` for Interface and Document and `Source Code Pro` for Monospace.

### Window Managers

```
sudo pacman -S xautolock
sudo pacman -S dunst
```

#### i3

```
sudo pacman -S i3-wm \
  i3lock \
  feh \
  picom \
  polybar \
  xorg-xrandr arandr \
  xss-lock 
```

#### Hyprland

```
sudo pacman -S hyprland \
  hyprlock \
  hyprpaper \
  qt6-wayland \
  xdg-desktop-portal-hyprland \
  swaync dolphin brightnessctl
yay -S ulauncher hyprshot
```

### Fonts

- Nerd Fonts
  ```
  sudo pacman -S ttf-cascadia-code-nerd ttf-cascadia-mono-nerd ttf-meslo-nerd
  ```

- VS Code fonts
  ```
  yay -S ttf-droid
  ```

### SSH Agent

```
mkdir -p ~/.config/systemd/user/
echo '
[Unit]
Description=SSH key agent

[Service]
Type=forking
Environment=SSH_AUTH_SOCK=%t/ssh-agent.socket
ExecStart=/usr/bin/ssh-agent -a $SSH_AUTH_SOCK

[Install]
WantedBy=default.target
' > ~/.config/systemd/user/ssh-agent.service

systemctl --user enable --now ssh-agent
```

Make sure SSH_AUTH_SOCK is set in shell:

```
echo 'export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"' >> ~/.bash_profile
```

Configure ssh to add keys to agent on first use, in `~/.ssh/config`:

```
Host *
    AddKeysToAgent yes
```

### Docker

```
sudo pacman -S docker docker-buildx docker-compose
sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo usermod -a -G docker alvaro
```

Restart or run `newgrp docker` on each shell session.

### 1Password

```
mkdir -p ~/Downloads/apps
cd ~/Downloads/apps
curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --import
git clone https://aur.archlinux.org/1password.git
cd 1password
makepkg -si
```

### TMUX plugins

```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins
```

### Avoid unexpected login locks

Edit `/etc/security/faillock.conf` and change:

```
deny = 10
unlock_time = 180
```

This way we have 10 attempts when entering passwords and even if the account gets locked it is only for 3 minutes.
