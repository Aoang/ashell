source "$HOME/.config/ashell/ashellrc.zsh"

ZSH_CONFIGS_DIR="$HOME/.config/ashell/zshrc"

if [ "$(ls -A $ZSH_CONFIGS_DIR)" ]; then
    for file in "$ZSH_CONFIGS_DIR"/*; do
        source "$file"
    done
fi

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPS="--extended"
