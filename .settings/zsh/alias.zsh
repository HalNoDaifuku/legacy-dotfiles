# alias
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias tree='tree -C'
alias ls='ls -F --color=auto'
alias ll='ls -lh'
alias la='ls -a'

if type apt > /dev/null 2>&1; then
    alias apt-fast="curl -fsSL 'https://raw.githubusercontent.com/ilikenwf/apt-fast/master/apt-fast' | bash -s --"
fi

if type colordiff > /dev/null 2>&1; then
    alias diff='colordiff'
fi

if type exa > /dev/null 2>&1; then
    alias exa='exa -F --color=auto'
    alias exal='exa -lh'
    alias exaa='exa -a'
fi

# alias ls='exa'
# alias cat='bat'
# alias find='fd'
