PLUGINS_DIR="$ZDOTDIR/plugins"
mkdir -p "$PLUGINS_DIR"

function zsh_add_file()
{
    [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

function zsh_add_plugin() {
    local repo=$1
    local name=$(basename "$repo")

    local dir="$PLUGINS_DIR/$name"

    if [ -d "$dir/.git" ]; then
        return
    fi

    git clone "https://github.com/$repo.git" "$dir"
}

function zsh_load_plugin() {
    local name=$1
    local dir="$PLUGINS_DIR/$name"

    if [ -f "$dir/$name.plugin.zsh" ]; then
        source "$dir/$name.plugin.zsh"
    elif [ -f "$dir/$name.zsh" ]; then
        source "$dir/$name.zsh"
    fi
}

function build_prompts()
{
    PROMPT=$'\n%~\n%# '
}
