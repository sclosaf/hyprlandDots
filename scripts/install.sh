#!/bin/bash

source ./source/mapping.sh

main()
{
    echo "Copying configuration file ..."

    for src in "${!mapping[@]}"; do

        local trg="${mapping[$src]}"
        mkdir -p "$(dirname "$trg")" || {
            echo "Failed to create directory for $trg"
            continue
        }

        if [[ -e "../$src" ]]; then
            echo "Copying $(basename "$src") to $trg..."
            if [[ -d "../$src" ]]; then
                cp -r "../$src" "$(dirname "$trg")" || {
                    echo "Error copying directory $src"
                }
            else
                cp "../$src" "$trg" || {
                    echo "Error copying file $src"
                }
            fi
        else
            echo  "Warning: $src not found, skipping...${NC}"
        fi
    done

    echo "Copy operation completed successfully."
}

main
