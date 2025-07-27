#!/bin/bash

installPackages() {
    local packages=(
        "package1"
        "package2"
        "package3"
    )

    echo "Updating package database..."
    sudo pacman -Sy --noconfirm || {
        echo "Error updating package database"
        exit 1
    }

    echo "Installing packages..."
    for pkg in "${packages[@]}"; do
        echo "Installing $pkg..."
        sudo pacman -S --noconfirm --needed "$pkg" || {
            echo "Error installing $pkg"
        }
    done
}

copyFiles() {
    declare -A file_map=(
        ["/path/to/source/file1"]="/path/to/destination/"
        ["/path/to/source/file2"]="/path/to/another/destination/"
    )

    echo "Copying files..."
    for source in "${!file_map[@]}"; do
        local dest="${file_map[$source]}"
        
        echo "Creating directory $dest (if needed)..."
        sudo mkdir -p "$dest" || {
            echo "Error creating directory $dest"
            continue
        }

        echo "Copying $source to $dest..."
        sudo cp "$source" "$dest" || {
            echo "Error copying $source to $dest"
        }
    done
}

main() {
    installPackages
    copyFiles
    echo "Operation completed"
}

main
