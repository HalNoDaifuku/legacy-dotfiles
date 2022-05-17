# PROMPT
PROMPT='┌ %F{cyan}%n@%m%f %F{magenta}%d%f
└ %# '
RPROMPT='%F{green}[%W %*]%f'

# zsh settings
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=3000
export SAVEHIST=3000
export HISTORY_IGNORE="(ipatool *|sl *|*email*|*password*)"
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt correct
setopt share_history
zshaddhistory() {
    emulate -L zsh
    [[ ${1%%$'\n'} != ${~HISTORY_IGNORE} ]]
}

# man(less) color
export LESS_TERMCAP_mb=$'\E[1;31m'
export LESS_TERMCAP_md=$'\E[1;36m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_us=$'\E[1;32m'
export LESS_TERMCAP_ue=$'\E[0m'
