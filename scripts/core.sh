#!/bin/bash

BOLD='\033[1m'
RESET='\033[0'

usage()
{
    echo "USAGE
  $0 [OPTIONS]

OPTIONS
  -h   --help            Print this message
  -i   --install         Install in the system
  -u   --uninstall       Uninstall from the system"
}

main()
{
    if ! ARGS=$(getopt -o 'hiup' --long 'help,install,uninstall,package' -n 'core.sh' -- "$@"); then
        usage
        exit 1
    fi

    if [ $? -ne 0 ]; then
        error "Terminating..." >&2
        exit 1
    fi

    eval set -- "$ARGS"
    unset ARGS

    while [[ $# -gt 0 ]]; do
        case "$1" in
            '-h' | '--help')
                usage
                exit 0
                ;;

            '-i' | '--initialize')
                ./init.sh
                exit 0
                ;;

            '-u' | '--uninstall')
                ./uninstall.sh
                exit 0
                ;;

            '-p' | '--package')
                ./package.sh
                exit 0
                ;;

            '--')
                shift
                break
                ;;
            *)
                error "Unexpected option '$1'" >&2
                exit 1
                ;;
        esac
    done
}

main "$@"
