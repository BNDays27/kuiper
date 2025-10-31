#!/bin/sh

# Installs the Chaotic AUR since I use it to install stuff like Zen and ungoogled chromium
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB

sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

sudo echo "[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf

sudo pacman -Syu --noconfirm

# Installs all of the dependencies and other stuff I use
sudo pacman -S plasma kitty konsole dolphin qt6ct-kde hyprland xdg-desktop-portal-hyprland hyprpaper eww hyprlock zen-browser-bin ungoogled-chromium-bin chromium-extension-web-store chromium-widevine neovim wl-clipboard hyprshot fzf paru-git git jq zsh elisa pipewire-alsa
