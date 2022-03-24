#!/usr/bin/env bash

# shellcheck disable=SC2059

# set -eu
set -eux


# export
export PACKAGE_LIST="
aria2
colordiff
curl
ffmpeg
gcc
gh
git
libssl-dev
make
mingw-w64
pkg-config
sl
tmux
tree
unar
vim
wget
winetricks
"
export PACKAGE_LIST=$(echo "$PACKAGE_LIST" | tr "\n" " ")


# platform
## Debian
if [ "$PLATFORM" = "Debian" ]; then
    sudo apt install -y lsb-release wget

    ## winehq
    printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Setting winehq..."
    sudo dpkg --add-architecture i386
    wget -nc https://dl.winehq.org/wine-builds/winehq.key
    sudo apt-key add winehq.key
    rm -f winehq.key
    echo "deb https://dl.winehq.org/wine-builds/debian/ $(lsb_release -c -s) main" | sudo tee /etc/apt/sources.list > /dev/null

## Ubuntu
elif [ "$PLATFORM" = "Ubuntu" ]; then
    sudo apt install -y lsb-release software-properties-common wget

    ### winehq
    printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Setting winehq..."
    sudo dpkg --add-architecture i386
    wget -nc https://dl.winehq.org/wine-builds/winehq.key
    sudo apt-key add winehq.key
    rm -f winehq.key
    sudo add-apt-repository "deb https://dl.winehq.org/wine-builds/ubuntu/ $(lsb_release -c -s) main"
fi

# apt install
## gh
sudo apt install -y curl
printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Setting gh..."
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/etc/apt/trusted.gpg.d/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/trusted.gpg.d/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

sudo apt update

## apt-fast
printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Installing apt-fast..."
if type apt > /dev/null 2>&1; then
    apt-fast() {
    curl -fsSL 'https://raw.githubusercontent.com/ilikenwf/apt-fast/master/apt-fast' | sh -s -- $*
    }
fi
echo "
_APTMGR=apt
DOWNLOADBEFORE=true
_MAXNUM=5
_MAXCONPERSRV=10
_SPLITCON=8
_MINSPLITSZ=1M
_PIECEALGO=default
DLLIST='/tmp/apt-fast.list'
_DOWNLOADER='aria2c --no-conf -c -j ${_MAXNUM} -x ${_MAXCONPERSRV} -s ${_SPLITCON} -i ${DLLIST} --min-split-size=${_MINSPLITSZ} --stream-piece-selector=${_PIECEALGO} --connect-timeout=600 --timeout=600 -m0'
DLDIR='/var/cache/apt/apt-fast'
APTCACHE='/var/cache/apt/archives'
" | sudo tee /etc/apt-fast.conf > /dev/null

## winehq
printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Installing winehq-staging..."
sudo apt-fast install -y --install-recommends winehq-staging

printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Installing $PACKAGE_LIST with apt-fast..."
sudo apt-fast install -y $PACKAGE_LIST

# end
printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "End $PLATFORM script"
