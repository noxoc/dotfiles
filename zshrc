export DOTDIR="$HOME/code/dotfiles"
zmodload zsh/zprof # profile startup time

# Terminal Setup {{{
export EDITOR='/usr/local/bin/nvim' # used for commits and such
export TERM='xterm-kitty'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
bindkey -e                          # use emacs keybindings
bindkey "^[" vi-cmd-mode            # use esc to enter vi-cmd-mode
unset MANPATH                       # use default manpath directories; it was different within tmux for some reason I do not yet know
autoload -U edit-command-line
zle -N edit-command-line # Emacs style
# Enable Ctrl-x-e to edit command line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
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

# load custom zsh modules
for file in "$DOTDIR"/zsh/*.zsh "$DOTDIR"/bin/*_completion; do
    if [[ -f "$file" ]]; then
        source "$file"
    fi
done

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform
eval "$(op completion zsh)"; compdef _op op
eval "$(starship init zsh)"
