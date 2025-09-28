#!/bin/bash

source ./source/pkgs.sh

main()
{
    echo "Installing yay ...."

    cd /tmp

    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm

    cd -

    echo "Updating packages database ..."

    if ![ command -v pacman &>/dev/null ]; then
        echo "Pacman not found. Aborting ..."
        exit 1
    fi

    sudo pacman -Sy --noconfirm || {
        echo "Error updating package database. Aborting ..."
            exit 1
    }

    for pkg in "${packages[@]}"; do
        [[ -z "$pkg" ]] && continue

        echo "Installing $pkg ..."

        sudo pacman -S --noconfirm --needed "$pkg" || {
            echo "Error installing $pkg."
    }

    done

    echo "Package installation completed successfully."
}

main
