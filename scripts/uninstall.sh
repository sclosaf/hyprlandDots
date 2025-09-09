#!/bin/bash

source ./source/mapping.sh

main()
{
    echo "Removing configuration files ..."

    for src in "${!mapping[@]}"; do
        local trg="${mapping[src]}"

        if [[ -e "$trg" ]]; then
            echo "Removing existing $trg ..."
            rm -rf "$trg"
        fi
    done

    echo "Removal operation completed successfully."
}

main
