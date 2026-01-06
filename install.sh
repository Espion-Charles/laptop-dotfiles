#!/bin/bash

if ! grep -q "^\[multilib\]" /etc/pacman.conf; then
    read -p "Would you like to enable multilib? (y/n): " confirm
    
    if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
        sudo sed -i '/^#\[multilib\]/,+1 s/^#//' /etc/pacman.conf
        sudo pacman -Syu
    else
        echo "Skipping multilib. Steam installation may fail."
    fi
fi

sudo pacman -Syu hyprland kitty noto-fonts dolphin discord steam grim slurp pipewire wireplumber quickshell xdg-desktop-portal-hyprland \
wofi okular qt6-wayland nvim hyprpaper hyprlock code zsh uwsm 



mkdir -p ~/Downloads

cd ~/Downloads || exit
git clone https://aur.archlinux.org/paru.git
cd paru/
makepkg -si
cd ~
paru -Syu zen-browser-bin zig

cd ~/Downloads
git clone https://codeberg.org/fairyglade/ly.git
cd ly/
zig build
sudo zig build installexe -Dinit_system=systemd
systemctl enable ly@tty2.service


cd ~



mkdir -p ~/.config

ln -s ~/laptop-dotfiles/hypr ~/.config
ln -s ~/laptop-dotfiles~/quickshell ~/.config



sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ln -sf ~/laptop-dotfiles/.zshrc ~
source /.zshrc
chsh -s zsh $(which zsh)
