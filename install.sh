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
    echo "building "
    makepkg -si
    echo "$aur_helper created"
fi

        
if [ "$AUR_INSTALLED" = true ] && ! command -v ly &> /dev/null; then
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