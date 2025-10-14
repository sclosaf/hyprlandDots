autoload -Uz compinit && compinit
autoload -U colors && colors
autoload -Uz vcs_info
setopt prompt_subst

if [[ $- == *i* ]] && command -v fastfetch >/dev/null 2>&1; then
    fastfetch
fi

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr ""
zstyle ':vcs_info:git:*' unstagedstr ""
zstyle ':vcs_info:git:*' formats " ${VCS_CLEAN_COLOR}%b%f"
zstyle ':vcs_info:git:*' actionformats " ${VCS_CLEAN_COLOR}%b%f${VCS_CONFLICTED_COLOR}|%a%f"

PROMPT_CHAR="${PROMPT_CHAR_COLOR}$ >%f"

autoload -Uz add-zsh-hook
add-zsh-hook precmd build_prompts
