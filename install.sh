#!/bin/bash

if ! grep -q "^\[multilib\]" /etc/pacman.conf; then
    echo "Adding multilib"
    sudo sed -i '/^#\[multilib\]/,+1 s/^#//' /etc/pacman.conf
    echo "Multilib added"
    sudo pacman -Syu
fi

echo "Installing basic stuff"
sudo pacman -Syu hyprland kitty noto-fonts dolphin discord grim slurp pipewire wireplumber quickshell xdg-desktop-portal-hyprland \
wofi okular qt6-wayland nvim hyprpaper hyprlock code zsh uwsm 
echo "Basic stuff installed"

if [ -d ~/downloads ]; then
    echo "Renaming ~/downloads directory"
    mv ~/downloads ~/Downloads
    echo "~/downloads directory renamed to ~/Downloads"
fi

if [ ! -d ~/Downloads ]; then
    echo "Creating ~/Downloads directory"
    mkdir -p ~/Downloads
    echo "~/Downloads folder created"
fi

aur_helper=""

if  command -v paru &> /dev/null; then 
    aur_helper="paru"

elif  command -v yay &> /dev/null; then
    aur_helper="yay"
else
    read -p "Do you want to install paru or yay? (P)Paru/(y)yay: -" choice
    
    case $choice in 
    [yY]*) aur_helper="yay" ;;
    *) aur_helper="paru" ;;
    esac
    echo "you choose $aur_helper"
    cd ~/Downloads
    echo "cloning $aur_helper"
    git clone https://aur.archlinux.org/$aur_helper.git
    echo "$aur_helper cloned"
    cd $aur_helper/
    echo "building $aur_helper"
    makepkg -si
    echo "$aur_helper created"
fi

echo "Installing important packages on the aur"
$aur_helper -Syu zen-browser-bin 
echo "Packages were properly installed"
        
if ! command -v ly &> /dev/null; then
    if ls /usr/bin/gdm &> /dev/null; then
        echo "deactivating gdm"
        systemctl stop gdm3.service
        systemctl disable dm3.service
        echo "gdm deactivated"
    elif ls /usr/bin/sddm &> /dev/null; then
        echo "deactivating sddm"
        systemctl stop sddm.service
        systemctl disable sddm.service
        echo "sddm deactivated"
    elif ls /usr/bin/lightdm &> /dev/null; then
        echo "deactivating lightdm"
        systemctl stop lightdm.service
        systemctl disable lightdm.service
        echo "lightdm deactivated"
    fi
    cd ~/Downloads
    echo "Cloning ly"
    git clone https://codeberg.org/fairyglade/ly.git
    cd ly/
    echo "building LY"
    zig build
    sudo zig build installexe -Dinit_system=systemd
    systemctl enable ly@tty2.service
    cd ~
fi


if [ ! -d ~/.config ]; then
    echo "Creating a config directory"
    mkdir -p ~/.config
    echo "Config directory created"
fi

if [ -d ~/.config/hypr ]; then
    echo "Backing up old hypr directory"
    mv ~/.config/hypr ~/.config/hypr.bak
    echo "Old hypr folder backed up"
fi

if [ -d ~/.config/quickshell ]; then
    echo "Backing up old quickshell directory"
    mv ~/.config/quickshell ~/.config/quickshell.bak
    echo "Old quickshell directory backed up"
fi

echo "Creating symlinks for the hypr and quickshell configs"
ln -sf ~/laptop-dotfiles/hypr ~/.config
ln -sf ~/laptop-dotfiles/quickshell ~/.config
echo "Symlinks created"


if [ ! -d "$~/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    chsh -s $(which zsh)
fi

if [ -d ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc.bak
fi

ln -sf ~/laptop-dotfiles/.zshrc ~
source ~/.zshrc

rm -fr ~/laptop-dofiles/.git