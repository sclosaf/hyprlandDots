#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

packages=(
    "hyprland"
    "vim"
)

declare -A config_mapping=(
    [".config/hypr"]="$HOME/.config/hypr"
    [".config/.vimrc"]="$HOME/"
)

installPackages(){
    echo -e "${GREEN}Updating package database...${NC}"
    sudo pacman -Sy --noconfirm || {
        echo -e "${RED}Error updating package database${NC}"
        exit 1
    }

    echo -e "${GREEN}Installing packages...${NC}"
    for pkg in "${packages[@]}"; do
        [[ -z "$pkg" ]] && continue
        echo -e "${GREEN}Installing $pkg...${NC}"
        sudo pacman -S --noconfirm --needed "$pkg" || {
            echo -e "${RED}Error installing $pkg${NC}"
        }
    done
}

copyFiles()
{
    echo -e "${GREEN}Copying configuration files...${NC}"

    for source_path in "${!config_mapping[@]}"; do
        local target_path="${config_mapping[$source_path]}"
        mkdir -p "$(dirname "$target_path")" || {
            echo -e "${RED}Failed to create directory for $target_path${NC}"
            continue
        }

        if [[ -e "$source_path" ]]; then
            echo -e "${GREEN}Copying $(basename "$source_path") to $target_path...${NC}"
            if [[ -d "$source_path" ]]; then
                cp -r "$source_path" "$(dirname "$target_path")" || {
                    echo -e "${RED}Error copying directory $source_path${NC}"
                }
            else
                cp "$source_path" "$target_path" || {
                    echo -e "${RED}Error copying file $source_path${NC}"
                }
            fi
        else
            echo -e "${YELLOW}Warning: $source_path not found, skipping...${NC}"
        fi
    done
}

main() {
    installPackages
    copyFiles
    echo -e "${GREEN}Operation completed!${NC}"
}

main
