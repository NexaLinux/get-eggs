#!/usr/bin/env bash

################################
function press_a_key_to_continue {
   read -rp ">> Press enter to continue or CTRL-C to abort."
}

function is_arch {
    RELEASE=$(lsb_release -is)
    if [ "$RELEASE" != "Arch" ]; then
        echo ">> ADDAUR is for Arch!"
        exit
    fi
}

function main {
    is_arch

    echo ""
    echo ">> ADDAURA: add spare tools..."
    echo ""
    pacman -Syu bash-completion \
                dialog \
                man-db \
                nano \
                openssh \
                wget

    echo ""
    echo ">> ADDAURA: add AUR repository..."
    echo ""
    echo 
    pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
    pacman-key --lsign-key 3056513887B78AEB
    pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
    echo "[chaotic-aur]" >> /etc/pacman.conf
    echo "Include = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf

    echo ""
    echo ">> ADDAURA: Installing penguins-eggs..."
    echo ""
    pacman -Syu penguins-eggs

    echo ""
    read -rp ">> ADDAURA: press a key to edit /etc/sudoers"
    echo ""
    export EDITOR=nano
    visudo

    clear
    echo ""
    echo ">> ADDAURA: cleaning"
    echo ""
    rm /addaura -rf
    read -rp ">> ADDAURA: finished!"
    
}

main
