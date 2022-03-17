export ZSHRC_PATH=$HOME

# zsh settings
source $ZSHRC_PATH/.settings/zsh/zsh.zsh

# alias
source $ZSHRC_PATH/.settings/zsh/alias.zsh

# function
source $ZSHRC_PATH/.settings/zsh/function.zsh

# Homebrew
if [ -d /opt/homebrew ] || [ -f /usr/local/bin/brew ]; then
    source $ZSHRC_PATH/.settings/homebrew/homebrew_settings.zsh
fi


# Rust
source "$HOME/.cargo/env"

if type sccache > /dev/null 2>&1; then
    export RUSTC_WRAPPER=$(which sccache)
elif type cachepot > /dev/null 2>&1; then
    export RUSTC_WRAPPER=$(which cachepot)
fi

# Wine
export WINE=wine64

# anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

# sheldon
eval "$(sheldon source)"

# PATH
export FPATH="$HOME/.zfunc:$FPATH"
export EDITOR='vim'

## Delete the same PATH
typeset -U PATH
typeset -U FPATH

# completions
autoload -Uz compinit; compinit

# starship
eval "$(starship init zsh)"
