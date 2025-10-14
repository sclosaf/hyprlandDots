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
        local additional_info=""

        local staged_count=$(git diff --staged --name-only 2>/dev/null | wc -l | tr -d ' ')
        if [[ $staged_count -gt 0 ]]; then
            additional_info+="${VCS_MODIFIED_COLOR}+${staged_count}%f "
        fi

        local unstaged_count=$(git diff --name-only 2>/dev/null | wc -l | tr -d ' ')
        if [[ $unstaged_count -gt 0 ]]; then
            additional_info+="${VCS_MODIFIED_COLOR}!${unstaged_count}%f "
        fi

        local ahead_behind=$(git rev-list --left-right --count HEAD...@'{u}' 2>/dev/null)
        if [[ -n "$ahead_behind" ]]; then
            local ahead=$(echo $ahead_behind | cut -f1)
            local behind=$(echo $ahead_behind | cut -f2)

            if [[ $behind -gt 0 ]]; then
                additional_info+="${VCS_CLEAN_COLOR}<${behind}%f "
            fi

            if [[ $ahead -gt 0 ]]; then
                if [[ $behind -gt 0 ]]; then
                    additional_info+="${VCS_CLEAN_COLOR}>${ahead}%f "
                else
                    additional_info+="${VCS_CLEAN_COLOR} >${ahead}%f "
                fi
            fi
        fi

        local stash_count=$(git stash list 2>/dev/null | wc -l | tr -d ' ')
        if [[ $stash_count -gt 0 ]]; then
            additional_info+="${VCS_CLEAN_COLOR}*${stash_count}%f "
        fi

        local untracked_count=$(git status --porcelain 2>/dev/null | grep '^??' | wc -l | tr -d ' ')
        if [[ $untracked_count -gt 0 ]]; then
            additional_info+="${VCS_UNTRACKED_COLOR}?${untracked_count}%f "
        fi

        local conflict_count=$(git diff --name-only --diff-filter=U 2>/dev/null | wc -l | tr -d ' ')
        if [[ $conflict_count -gt 0 ]]; then
            additional_info+="${VCS_CONFLICTED_COLOR}~${conflict_count}%f "
        fi

        if [[ -n "$additional_info" ]]; then
            echo "${git_info} ${additional_info}"
        else
            echo "$git_info"
        fi
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
