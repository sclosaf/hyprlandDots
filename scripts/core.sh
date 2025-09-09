#!/bin/bash

BOLD='\033[1m'
RESET='\033[0'

usage()
{
    echo "
USAGE
\t$0 [OPTIONS]

OPTIONS
\t-h, --help\t\t\tPrint this message
\t-i, --install\t\tInstall in the system
\t-u, --uninstall\t\tUninstall from the system"
}

main()
{
    if ! ARGS=$(getopt -o 'hiu' --long 'help,install,uninstall' -n 'core.sh' -- "$@"); then
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

            '-i' | '--install')
                ./install.sh
                exit 0
                ;;

            '-u' | '--uninstall')
                ./uninstall.sh
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
