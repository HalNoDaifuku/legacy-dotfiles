#!/usr/bin/env bash

# shellcheck disable=SC2059

# set -eu
set -eux

shopt -s expand_aliases

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

alias sudo='sudo '

sudo apt install -y curl gnupg2 lsb-release software-properties-common wget

# platform
## Debian
if [ "$PLATFORM" = "Debian" ]; then

    # ### apt-fast
    # printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Setting apt-fast..."
    # echo "deb http://ppa.launchpad.net/apt-fast/stable/ubuntu $(curl -fsSL 'https://github.com/tianon/docker-brew-ubuntu-core/raw/dist-amd64/latest') main" | sudo tee /etc/apt/sources.list.d/apt-fast.list > /dev/null
    # echo "deb-src http://ppa.launchpad.net/apt-fast/stable/ubuntu $(curl -fsSL 'https://github.com/tianon/docker-brew-ubuntu-core/raw/dist-amd64/latest') main" | sudo tee -a /etc/apt/sources.list.d/apt-fast.list > /dev/null
    # sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A2166B8DE8BDC3367D1901C11EE2FF37CA8DA16B

    ## winehq
    printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Setting winehq..."
    sudo dpkg --add-architecture i386
    wget -nc https://dl.winehq.org/wine-builds/winehq.key
    sudo apt-key add winehq.key
    rm -f winehq.key
    echo "deb https://dl.winehq.org/wine-builds/debian/ $(lsb_release -c -s) main" | sudo tee /etc/apt/sources.list > /dev/null

## Ubuntu
elif [ "$PLATFORM" = "Ubuntu" ]; then

    ### apt-fast
    printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Setting apt-fast..."
    sudo add-apt-repository ppa:apt-fast/stable

    sudo apt update

    printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Installing apt-fast..."

    sudo touch /etc/apt-fast.conf
    export DEBIAN_FRONTEND=noninteractive
    echo y | sudo apt install -y apt-fast

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

    alias apt='apt-fast'

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
printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Setting gh..."
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/etc/apt/trusted.gpg.d/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/trusted.gpg.d/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

sudo apt update

## winehq
printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Installing winehq-staging..."
sudo apt install -y --install-recommends winehq-staging

printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Installing $PACKAGE_LIST with apt-fast..."
sudo apt install -y $PACKAGE_LIST

# end
printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "End $PLATFORM script"
