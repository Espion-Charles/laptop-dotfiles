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

sudo pacman -Syu hyprland kitty noto-fonts dolphin discord grim slurp pipewire wireplumber quickshell xdg-desktop-portal-hyprland \
wofi okular qt6-wayland nvim hyprpaper hyprlock code zsh uwsm 

if [-d ~/downloads]; then
mv ~/downloads ~/Downloads
fi

if [ ! -d ~/Downloads ]; then
mkdir -p ~/Downloads
echo "~/Downloads folder created"
fi

AUR_INSTALLED=false

if command -v paru &> /dev/null; then
    paru -Syu zen-browser-bin zig
    AUR_INSTALLED=true
    else
    PS3='Choose one of these option (1-3):'
    options=("I want paru" "I have yay already" "No")
    
    select opt in "${options[@]}"
    do 
        case $opt in
        
        "I want paru") 
            cd ~/Downloads || exit
            echo "Cloning paru"
            git clone https://aur.archlinux.org/paru.git
            cd paru/
            echo "Creating paru"
            makepkg -si
            echo "paru created"
            cd ~
            echo "Installing important stuff"
            paru -Syu zen-browser-bin zig
            AUR_INSTALLED=true
            break
            ;;
        "I have yay already")
            echo "Installing important stuff"
            yay -Syu zen-browser-bin zig
            AUR_INSTALLED=true
            break
            ;;
        "No")
            echo "wtf brother, why did you choose that, no ly for you"
            AUR_INSTALLED=false
            break
            ;;
        esac
    done

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



mkdir -p ~/.config

if [ -d ~/.config/hypr ]; then
mv ~/.config/hypr ~/.config/hypr.bak
fi

if [ -d ~/.config/quickshell ]; then
mv ~/.config/hypr ~/.config/hypr.bak
fi

ln -sf ~/laptop-dotfiles/hypr ~/.config
ln -sf ~/laptop-dotfiles/quickshell ~/.config


if ! command -v zsh &> /dev/null; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    chsh -s zsh $(which zsh)
fi
if [ -d ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc.bak
fi

ln -sf ~/laptop-dotfiles/.zshrc ~
source ~/.zshrc