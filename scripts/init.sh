#!/bin/bash

source ./source/mapping.sh

main()
{
    echo "Copying configuration files..."

    for source_path in "${!mapping[@]}"; do
        local target_path="${mapping[$source_path]}"

        if [[ -e "$target_path" ]]; then
            echo "Removing existing $target_path..."
            rm -rf "$target_path"
        fi

        mkdir -p "$(dirname "$target_path")" || {
            echo "Failed to create directory for $target_path"
            continue
        }

        if [[ -e "../$source_path" ]]; then
            echo "Copying $(basename "$source_path") to $target_path..."

            if [[ -d "../$source_path" ]]; then
                cp -r "../$source_path" "$(dirname "$target_path")" || {
                    echo "Error copying directory $source_path"
                }
            else
                cp "../$source_path" "$target_path" || {
                    echo "Error copying file $source_path"
                }
            fi
        else
            echo -e "Warning: ../$source_path not found, skipping..."
        fi
    done

    echo -e "Operation completed!"
}

main
