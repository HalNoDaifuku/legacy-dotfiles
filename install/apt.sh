#!/bin/zsh

set -eu


# export
export PACKAGE_LIST="
aria2
colordiff
curl
docker-ce
docker-ce-cli
containerd.io
ffmpeg
gcc
gh
git
make
mingw-w64
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
    ### apt-fast
    printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Setting apt-fast..."
    echo "deb http://ppa.launchpad.net/apt-fast/stable/ubuntu bionic main" | sudo tee /etc/apt/sources.list.d/apt-fast.list > /dev/null
    echo "deb-src http://ppa.launchpad.net/apt-fast/stable/ubuntu bionic main" | sudo tee -a /etc/apt/sources.list.d/apt-fast.list > /dev/null
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A2166B8DE8BDC3367D1901C11EE2FF37CA8DA16B

## Ubuntu
elif [ "$PLATFORM" = "Ubuntu" ]; then
    sudo apt install -y software-properties-common lsb-release wget

    ### apt-fast
    printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Setting apt-fast..."
    sudo add-apt-repository ppa:apt-fast/stable

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

## apt-fast
printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Installing apt-fast..."
sudo touch /etc/apt-fast.conf
sudo apt install -y apt-fast
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
sudo apt-fast install -y winehq-staging

printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Installing packages..."
sudo apt-fast install -y $PACKAGE_LIST
