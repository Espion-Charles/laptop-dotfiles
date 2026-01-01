#!/bin/bash

sudo pacman -S hyprland kitty noto-fonts dolphin discord steam grim slurp pipewire wireplumber quickshell xdg-desktop-portal-hyprland wofi okular qt6-wayland nvim hyprpaper hyprlock code zsh

mkdir -p ~/Downloads

cd ~/Downloads || exit
git clone https://aur.archlinux.org/paru.git
cd paru/
makepkg -si

cd ~

paru -Syu zen-browser-bin

mkdir -p ~/.config

ln -s ~/laptop-dotfiles/hypr ~/.config
ln -s ~/laptop-dotfiles~/quickshell ~/.config

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ln -sf ~/laptop-dotfiles/.zshrc ~