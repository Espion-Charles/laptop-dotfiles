#!/bin/bash

sudo pacman -S hyprland kitty noto-fonts dolphin discord steam grim slurp pipewire wireplumber quickshell xdg-desktop-portal-hyprland wofi okular qt6-wayland nvim hyprpaper hyprlock

mkdir Downloads

cd -p ~/Downloads
git clone https://aur.archlinux.org/paru.git
cd paru/
makepkg -si

paru -Syu zen-browser-bin


if [ -d "~/.config/hypr" ] && [ ! -L "~/.config/hypr" ]; then
    mv ~/.config/hypr ~/.config/hypr.bak
fi

ln -s ~/laptop-dotfiles/hypr ~/.config
ln -s ~/laptop-dotfiles/quickshell ~/.config

