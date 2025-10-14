function zsh_add_file()
{
    [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

function zsh_add_plugin()
{
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)

    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
    fi
}

function git_formatter()
{
    vcs_info

    if [[ -n "$vcs_info_msg_0_" ]]; then
        local git_info="$vcs_info_msg_0_"
        local symbols=""

        if [[ -n "$(git status --porcelain 2>/dev/null)" ]]; then
            symbols+="${VCS_MODIFIED_COLOR}!%f"
        fi

        local upstream=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)
        if [[ -n "$upstream" ]]; then
            local ahead=$(git rev-list --count HEAD.."$upstream" 2>/dev/null)
            if [[ $ahead -gt 0 ]]; then
                symbols+="${VCS_CLEAN_COLOR}?%f"
            fi
        fi

        if [[ -z "$symbols" ]]; then
            symbols+="${VCS_CLEAN_COLOR}>%f"
        fi

        echo "${git_info} ${symbols}"
    fi
}

function get_virtualenv()
{
    if [[ -n "$VIRTUAL_ENV" ]]; then
        local venv_name=$(basename "$VIRTUAL_ENV")
        echo "$venv_name"
    fi
}

function prompt_dir()
{
    echo -n "${DIR_BOLD}${DIR_COLOR}%~%f%b"
}

function prompt_vcs()
{
    local git_info=$(git_formatter)
    if [[ -n "$git_info" ]]; then
        echo -n "$git_info"
    fi
}

function prompt_virtualenv()
{
    local venv=$(get_virtualenv)
    if [[ -n "$venv" ]]; then
        echo -n "${VIRTUALENV_COLOR}${venv}%f"
    fi
}

function prompt_time()
{
    echo -n "${TIME_COLOR}$(date +%H:%M:%S)%f"
}

function build_prompts()
{
    PROMPT=""

    PROMPT+=$'\n'
    PROMPT+="$(prompt_dir)"
    PROMPT+="$(prompt_vcs)"

    PROMPT+=$'\n'
    PROMPT+="${PROMPT_CHAR} "

    RPROMPT=""

    local venv=$(prompt_virtualenv)
    if [[ -n "$venv" ]]; then
        RPROMPT+="$venv "
    fi

    RPROMPT+="$(prompt_time)"

    RPROMPT="${RPROMPT% }"
}
