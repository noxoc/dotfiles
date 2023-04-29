export DOTDIR="$HOME/code/dotfiles"

# Terminal Setup {{{
export EDITOR='/usr/local/bin/nvim' # used for commits and such
export TERM='xterm-kitty'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# }}}

declare -U PATH path
path=(
  "/opt/homebrew/opt/bison/bin"
  "/opt/homebrew/opt/grep/libexec/gnubin" 
  "$DOTDIR/bin/"
  "$BUN_INSTALL/bin"
  "$HOME/.composer/vendor/bin"
  "$HOME/.local/bin"
  "$HOME/bin"
  "$HOME/bin:"
  "$HOME/code/bleepbloop.git/main/bin"
  "$PNPM_HOME"
  "./node_modules/.bin"
  "/opt/homebrew/bin"
  "/usr/local/bin" 
  "/usr/local/cuda-11.6/bin"
  "$path[@]"
)
export PATH
export PYENV_ROOT="$HOME/.pyenv"
export LD_LIBRARY_PATH="/usr/local/cuda-11.6/lib64:$LD_LIBRARY_PATH"
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

# oh my zsh {{{
export ZSH_CUSTOM=$DOTDIR/omz-custom
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="bleep"
zstyle ':omz:update' mode disabled  # just remind me to update when it's time
zstyle ':omz:update' frequency 13
plugins=(aliases npm yarn nvm fzf tmux z git)
source $ZSH/oh-my-zsh.sh
# }}}

# load custom zsh modules
for file in "$DOTDIR"/zsh/*.zsh "$DOTDIR"/bin/*_completion; do
    if [ -f "$file" ]; then
        source "$file"
    fi
done

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform
eval "$(op completion zsh)"; compdef _op op
