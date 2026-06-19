# dotfiles

My Arch Linux + Hyprland setup. Managed with [GNU stow](https://www.gnu.org/software/stow/).

## Layout

Each top-level directory is a *stow package* that mirrors `$HOME`:

| Package   | Contents                                  |
|-----------|-------------------------------------------|
| `hypr`    | Hyprland compositor (`hyprland.lua`)      |
| `kitty`   | Kitty terminal                            |
| `fish`    | Fish shell                                |
| `zsh`     | `.zshrc`                                   |
| `starship`| Starship prompt (`starship.toml`)         |
| `btop`    | btop system monitor (Catppuccin Mocha)    |
| `yazi`    | Yazi file manager (Catppuccin Mocha)      |
| `htop`    | htop                                      |
| `misc`    | `mimeapps.list`, `dolphinrc`              |
| `packages`| Reproducible package lists (not stowed)   |

## Restore on a fresh machine

```sh
sudo pacman -S --needed stow git
git clone https://github.com/<user>/dotfiles ~/dotfiles
cd ~/dotfiles

# symlink configs into place (--adopt pulls in any pre-existing files, then `git checkout .` to keep repo versions)
stow --adopt hypr kitty fish zsh starship btop yazi htop misc
git checkout .

# reinstall packages
sudo pacman -S --needed - < packages/pacman-native.txt
# AUR (needs an AUR helper like yay):
yay -S --needed - < packages/aur.txt
```

> First time on *this* machine: run `stow --adopt <pkg>` once to replace the
> real config files with symlinks into this repo. After that, editing a config
> edits the repo directly.

## System setup not captured by dotfiles

These live in `/etc` (root-owned) and must be redone manually after an install:

- **GPU**: GeForce GTX 1080 (Pascal) → AUR `nvidia-580xx-dkms nvidia-580xx-utils opencl-nvidia-580xx`
  (the last NVIDIA branch that supports Pascal; repo `nvidia-open` does not).
- `/etc/mkinitcpio.conf`: `MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)`
- `/etc/kernel/cmdline`: append `nvidia_drm.modeset=1 nvidia_drm.fbdev=1`
- `/etc/modprobe.d/blacklist-nouveau.conf`: `blacklist nouveau`
- `/boot/loader/loader.conf`: `default arch-linux.efi` (stock `linux` kernel; `linux-lts` is the fallback — both carry the NVIDIA driver, `linux-hardened` does not)
- Rebuild: `sudo mkinitcpio -P`
