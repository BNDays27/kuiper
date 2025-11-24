#!/bin/sh
#############################
### SCRIPT TIME YAYYYYYYY ###
#############################

# just prefacing here you will need to be near your pc as this script won't automatically install stuff like your QT theme, so be ready to change anything

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
clear
echo "hey! You will need to be alert for the install, some of this isn't automatic so don't go make a coffee or something when installing this (y/N)"
read option

if [[ $option = "y" ]]; then
	echo "cool, have fun!"
else
	echo "well then bye"
	exit 0
fi
clear

# Installs the Chaotic AUR repo since I use it to install stuff like Zen and ungoogled chromium easier
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB

sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' --noconfirm
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm

sudo echo "[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf

sudo pacman -Syu --noconfirm

# Installs all of the dependencies and other stuff I use
sudo pacman -Syu stow plasma kitty konsole flatpak discover dolphin qt6ct-kde hyprland xdg-desktop-portal-hyprland hyprpaper eww hyprlock zen-browser-bin ungoogled-chromium-bin chromium-extension-web-store chromium-widevine neovim wl-clipboard hyprshot fzf paru-git git jq zsh elisa pipewire-alsa ark unrar unzip wget ttf-jetbrains-mono ttf-jetbrains-mono-nerd btop rocm-smi-lib fastfetch mpd rmpc steam hyprpicker wlogout power-profiles-daemon noto-fonts-cjk spotify spicetify-cli spicetify-marketplace-bin papirus-icon-theme sddm mpd-mpris openssh --needed --noconfirm

# installing AUR packages with paru
paru -S btop-theme-catppuccin plymouth-theme-catppuccin-mocha-git papirus-folders-catppuccin-git catppuccin-sddm-theme-mocha --noconfirm --needed

sudo chown $USER /tmp/mpd_mpris

# sets Papirus' & Plymouth's theme to Catppuccin Mocha (specifically mauve for papirus)
plymouth-set-default-theme -R catppuccin-mocha
papirus-icon-theme -C cat-mocha-mauve --theme Papirus-Dark


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
systemctl enable mpd mpd-mpris
systemctl enable --now mpd mpd-mpris

# changes the shell to zsh, you CAN use bash if you want but I dont use it, so i just have my aliases in there, the OMP theme, the fastfetch thing and that's it
chsh -s /bin/zsh

# stows the dotfiles
cd $SCRIPT_DIR
rm -rf $HOME/.config/*
stow .
echo "okay, we're done, have a fun time using the dots!
You will need to set up Spotify & spicetify manually, as there's no way for me to set it up manually
maybe i'll try automate more of this, but dont count on it!
"
