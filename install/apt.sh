#!/usr/bin/env bash

# shellcheck disable=SC2059

# set -eu
set -eux

shopt -s expand_aliases

# export
export PACKAGE_LIST="
aria2
cmake
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

export DEBIAN_FRONTEND=noninteractive
sudo apt install -y tzdata
sudo apt install -y curl gnupg2 lsb-release software-properties-common

### apt-fast
printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Setting apt-fast..."
sudo apt install -y aria2
sudo add-apt-repository ppa:apt-fast/stable

### winehq
printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Setting winehq..."
sudo dpkg --add-architecture i386
curl -fsSL https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
sudo add-apt-repository "deb https://dl.winehq.org/wine-builds/ubuntu/ $(lsb_release -c -s) main"

# apt install
## gh
printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Setting gh..."
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/etc/apt/trusted.gpg.d/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/trusted.gpg.d/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

sudo apt update

## apt-fast
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

## winehq
printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Installing winehq-staging..."
sudo apt install -y --install-recommends winehq-staging

printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Installing $PACKAGE_LIST with apt-fast..."
sudo apt install -y $PACKAGE_LIST

# end
printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "End $PLATFORM script"
