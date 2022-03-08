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
    echo "deb http://ppa.launchpad.net/apt-fast/stable/ubuntu bionic main" | sudo tee /etc/apt/sources.list.d/apt-fast.list > /dev/null
    echo "deb-src http://ppa.launchpad.net/apt-fast/stable/ubuntu bionic main" | sudo tee -a /etc/apt/sources.list.d/apt-fast.list > /dev/null
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A2166B8DE8BDC3367D1901C11EE2FF37CA8DA16B

## Ubuntu
elif [ "$PLATFORM" = "Ubuntu" ]; then
    echo test
    sudo apt install -y software-properties-common lsb-release

    ### apt-fast
    sudo add-apt-repository ppa:apt-fast/stable

    ### winehq
    sudo add-apt-repository "deb https://dl.winehq.org/wine-builds/ubuntu/ $(lsb-release -c -s) main"
fi

# apt install
## gh
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/etc/apt/trusted.gpg.d/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/trusted.gpg.d/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

sudo apt update
sudo apt install -y apt-fast
sudo apt-fast install -y --install-recommends winehq-staging
sudo apt-fast install -y $PACKAGE_LIST
