export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

export PATH="$HOME/bin:$PATH"
export EDITOR=nano
export TERM=xterm-256color

alias ll='ls -lah'
alias la='ls -A'
alias gs='git status'
alias gp='git pull'
alias gd='git diff'

autoload -Uz colors
colors
export FgNord0="%F{234}"
export FgNord1="%F{239}"
export FgNord2="%F{243}"
export FgNord3="%F{250}"
export FgNord4="%F{255}"

PROMPT='%F{cyan}%~%f
$ %F{blue}o%f %F{green}#%f '

