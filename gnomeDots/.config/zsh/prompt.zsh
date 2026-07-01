autoload -Uz compinit && compinit
autoload -U colors && colors
setopt prompt_subst
autoload -Uz add-zsh-hook
add-zsh-hook precmd build_prompts
