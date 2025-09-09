#!/bin/bash

packages=(
    "hyprland"
    "vim"
)

declare -A mapping=(
    ["../.config/hypr"]="$HOME/.config/hypr"
    ["../.config/.vimrc"]="$HOME/"
)

copyFiles()
{
    echo -e "Copying configuration files..."

    for source_path in "${!mapping[@]}"; do
        local target_path="${mapping[$source_path]}"
        mkdir -p "$(dirname "$target_path")" || {
            echo -e "Failed to create directory for $target_path"
            continue
        }

        if [[ -e "$source_path" ]]; then
            echo -e "Copying $(basename "$source_path") to $target_path..."
            if [[ -d "$source_path" ]]; then
                cp -r "$source_path" "$(dirname "$target_path")" || {
                    echo -e "Error copying directory $source_path"
                }
            else
                cp "$source_path" "$target_path" || {
                    echo -e "Error copying file $source_path"
                }
            fi
        else
            echo -e "Warning: $source_path not found, skipping..."
        fi
    done
}

main()
{
    installPackages
    copyFiles
    echo -e "${GREEN}Operation completed!"
}

main
