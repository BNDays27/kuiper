#!/bin/sh

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Installs the Chaotic AUR since I use it to install stuff like Zen and ungoogled chromium
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB

sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

sudo echo "[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf

sudo pacman -Syu --noconfirm

# Installs all of the dependencies and other stuff I use
sudo pacman -Syu stow plasma kitty konsole dolphin qt6ct-kde hyprland xdg-desktop-portal-hyprland hyprpaper eww hyprlock zen-browser-bin ungoogled-chromium-bin chromium-extension-web-store chromium-widevine neovim wl-clipboard hyprshot fzf paru-git git jq zsh elisa pipewire-alsa ark unrar unzip wget ttf-jetbrains-mono ttf-jetbrains-mono-nerd --needed --noconfirm

# installs the QT theme for KDE, I use Catppuccin so its catppuccin/kde
mkdir $HOME/.git
cd $HOME/.git
git clone --depth=1 https://github.com/catppuccin/kde catppuccin-kde 
cd catppuccin-kde
./install.sh

# installs the GTK theme, Catppuccin used to have one but that's archived now so I'm using Fausto-Korpsvart/Catppuccin-GTK-Theme
cd $HOME/.git
git clone https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme.git catppuccin-gtk
cd catppuccin-gtk/themes
./install.sh --tweaks macos -t mauve

cd $SCRIPT_DIR
rm -rf $HOME/.config/*
stow .
