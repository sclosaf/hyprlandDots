if [[ $- == *i* ]] && command -v fastfetch >/dev/null 2>&1; then
    fastfetch
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

export FZF_DEFAULT_OPTS='--color=fg:#e5e9f0,hl:#81a1c1 --color=fg+:#e5e9f0,bg+:#3b4252,hl+:#81a1c1 --color=info:#5d6a82,prompt:#b48dac,pointer:#b48dac --color=marker:#5d6a82,spinner:#b48dac,header:#5d6a82'

zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zstyle ':fzf-tab:*' use-fzf-default-opts yes

autoload -Uz compinit && compinit
zinit cdreplay -q

HISTSIZE=1000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups \
    hist_save_no_dups hist_ignore_dups hist_find_no_dups

alias ls='ls -la --color'

alias ff='clear && fastfetch'
alias vim='nvim'
alias c='clear'

autoload -U colors && colors
autoload -Uz vcs_info
setopt prompt_subst

# Directory colors
DIR_COLOR='%F{#7891be}'
DIR_BOLD='%B'

# Git colors
VCS_CLEAN_COLOR='%F{#5d6a82}'
VCS_MODIFIED_COLOR='%F{#6b6875}'
VCS_UNTRACKED_COLOR='%F{#6b6875}'
VCS_CONFLICTED_COLOR='%F{#bf616a}'

# Prompt char colors
PROMPT_CHAR_COLOR='%F{#ae95ac}'

# Virtual environment color
VIRTUALENV_COLOR='%F{#88c0d0}'

# Time color
TIME_COLOR='%F{#748495}'

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true

zstyle ':vcs_info:git:*' stagedstr "${VCS_MODIFIED_COLOR}+%f"
zstyle ':vcs_info:git:*' unstagedstr "${VCS_MODIFIED_COLOR}%f"
zstyle ':vcs_info:git:*' formats " ${VCS_CLEAN_COLOR}%b%f%c%u"
zstyle ':vcs_info:git:*' actionformats " ${VCS_CLEAN_COLOR}%b%f${VCS_CONFLICTED_COLOR}|%a%f%c%u"

function git_formatter()
{
    vcs_info

    if [[ -n "$vcs_info_msg_0_" ]]; then
        local git_info="$vcs_info_msg_0_"
        local additional_info=""

        # Count staged files
        local staged_count=$(git diff --staged --name-only 2>/dev/null | wc -l | tr -d ' ')
        if [[ $staged_count -gt 0 ]]; then
            additional_info+="${VCS_MODIFIED_COLOR}+${staged_count}%f"
        fi

        # Count unstaged files
        local unstaged_count=$(git diff --name-only 2>/dev/null | wc -l | tr -d ' ')
        if [[ $unstaged_count -gt 0 ]]; then
            additional_info+="${VCS_MODIFIED_COLOR}!${unstaged_count}%f"
        fi

        # Ahead/Behind information
        local ahead_behind=$(git rev-list --left-right --count HEAD...@'{u}' 2>/dev/null)
        if [[ -n "$ahead_behind" ]]; then
            local ahead=$(echo $ahead_behind | cut -f1)
            local behind=$(echo $ahead_behind | cut -f2)

            if [[ $behind -gt 0 ]]; then
                additional_info+="${VCS_CLEAN_COLOR}<${behind}%f"
            fi

            if [[ $ahead -gt 0 ]]; then
                if [[ $behind -gt 0 ]]; then
                    additional_info+="${VCS_CLEAN_COLOR}>${ahead}%f"
                else
                    additional_info+="${VCS_CLEAN_COLOR} >${ahead}%f"
                fi
            fi
        fi

        # Stashes
        local stash_count=$(git stash list 2>/dev/null | wc -l | tr -d ' ')
        if [[ $stash_count -gt 0 ]]; then
            additional_info+="${VCS_CLEAN_COLOR}*${stash_count}%f"
        fi

        # Untracked files
        local untracked_count=$(git status --porcelain 2>/dev/null | grep '^??' | wc -l | tr -d ' ')
        if [[ $untracked_count -gt 0 ]]; then
            additional_info+="${VCS_UNTRACKED_COLOR}?${untracked_count}%f"
        fi

        # Conflict information
        local conflict_count=$(git diff --name-only --diff-filter=U 2>/dev/null | wc -l | tr -d ' ')
        if [[ $conflict_count -gt 0 ]]; then
            additional_info+="${VCS_CONFLICTED_COLOR}~${conflict_count}%f"
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

# VI MODE SUPPORT
function zle-line-init zle-keymap-select
{
    case $KEYMAP in
        vicmd)
            PROMPT_CHAR="${PROMPT_CHAR_COLOR}<%f"
            ;;
        vivis|vivli)
            PROMPT_CHAR="${PROMPT_CHAR_COLOR}V%f"
            ;;
        main|viins)
            PROMPT_CHAR="${PROMPT_CHAR_COLOR}$ >%f"
            ;;
    esac

    build_prompts
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

function build_prompts()
{
    PROMPT=""

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

PROMPT_CHAR="${PROMPT_CHAR_COLOR}$ >%f"

autoload -Uz add-zsh-hook
add-zsh-hook precmd build_prompts

build_prompts
precmd() { echo }
