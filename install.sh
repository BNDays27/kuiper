#!/bin/sh
#############################
### SCRIPT TIME YAYYYYYYY ###
#############################

# just prefacing here you will need to be near your pc as this script won't automatically install stuff like your QT theme, so be ready to change anything

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Installs the Chaotic AUR repo since I use it to install stuff like Zen and ungoogled chromium easier
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB

sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

sudo echo "[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf

sudo pacman -Syu --noconfirm

# Installs all of the dependencies and other stuff I use
sudo pacman -Syu stow plasma kitty konsole flatpak discover dolphin qt6ct-kde hyprland xdg-desktop-portal-hyprland hyprpaper eww hyprlock zen-browser-bin ungoogled-chromium-bin chromium-extension-web-store chromium-widevine neovim wl-clipboard hyprshot fzf paru-git git jq zsh elisa pipewire-alsa ark unrar unzip wget ttf-jetbrains-mono ttf-jetbrains-mono-nerd btop rocm-smi-lib fastfetch mpd rmpc mpd-mpris steam hyprpicker wlogout --needed --noconfirm

# Installs the QT theme for KDE, I use Catppuccin so its catppuccin/kde
mkdir $HOME/.git
cd $HOME/.git
git clone --depth=1 https://github.com/catppuccin/kde catppuccin-kde 
cd catppuccin-kde
./install.sh

# Installs the GTK theme, Catppuccin used to have one but that's archived now so I'm using Fausto-Korpsvart/Catppuccin-GTK-Theme
cd $HOME/.git
git clone https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme.git catppuccin-gtk
cd catppuccin-gtk/themes
./install.sh --tweaks macos -t mauve

# So Flatpaks use the GTK theme
sudo flatpak override --filesystem=$HOME/.themes

# So mpd and mpd-mpris launch now and on startup
systemctl enable --now mpd mpd-mpris

# Btop theme, again uses Catppuccin, but this time im symlinking because that's easier
cd $HOME/.git
git clone https://github.com/catppuccin/btop catppuccin-btop
mkdir -p $HOME/.config/btop/
ln -s $HOME/.git/catppuccin-btop/themes $HOME/.config/btop/themes

# changes the shell to zsh, you CAN use bash if you want but I dont use it, so i just have my aliases in there, the OMP theme, the fastfetch thing and that's it
chsh -s /bin/zsh

cd $SCRIPT_DIR
rm -rf $HOME/.config/*
stow .
echo "okay, we're done, have a fun time using the dots!"
