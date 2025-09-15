#!/bin/bash

source ./source/fonts.sh

targetDir="$HOME/.local/share/fonts"
mkdir -p "$targetDir"

echo "Installation ..."

for fontName in "${!fontList[@]}"; do
    packageName="${fontList[$fontName]}"

    echo "Installing: $fontName (package: $packageName)"

    if yay -S --noconfirm "$packageName"; then
	echo "Successfully installed: $fontName"
    else
	echo "Failed to install: $fontName"
    fi
done

echo "Updating font cache"
fc-cache -fv "$targetDir"
