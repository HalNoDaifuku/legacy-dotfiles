#!/usr/bin/env bash

# shellcheck disable=SC2059

# set -eu
set -eux


# export
export SCRIPT_DIR=$(cd $(dirname $0); pwd)
export INSTALL_DIR="$HOME"
export LINK_FILES="
Library/LaunchAgents/aria2c.rpc.plist
.config/starship.toml
.config/sheldon/plugins.toml
.gitconfig
.tmux.conf
.vimrc
.zshrc
"
export LINK_FOLDERS="
.settings
"
export CARGO_INSTALL="
bat
cargo-binutils
cargo-outdated
cargo-update
cargo-watch
exa
fd-find
sccache
sheldon
starship
"
## color
export PRINTF_CYAN="\033[1;36m%s"
export PRINTF_DELETE_LINE="\033[m\n"

export LINK_FILES=$(echo "$LINK_FILES" | tr "\n" " ")
export LINK_FOLDERS=$(echo "$LINK_FOLDERS" | tr "\n" " ")
export CARGO_INSTALL=$(echo "$CARGO_INSTALL" | tr "\n" " ")

pushd "$SCRIPT_DIR"


# Symbolic link
## files
printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Linking files..."

for files in $LINK_FILES
do
    echo "$files"
    mkdir -p "$INSTALL_DIR/$(dirname "$files")"
    ln -nfs "$SCRIPT_DIR/$files" "$INSTALL_DIR/$files"
done

## folders
printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Linking folders..."

for folders in $LINK_FOLDERS
do
    echo "$folders/"

    # Delete
    if [ -L "$INSTALL_DIR/$folders" ]; then
        unlink "$INSTALL_DIR/$folders"
    elif [ -d "$INSTALL_DIR/$folders/" ]; then
        rm -rf "$INSTALL_DIR/$folders/"
    fi

    mkdir -p "$INSTALL_DIR/$(dirname "$folders")"
    pushd "$INSTALL_DIR/$(dirname "$folders")"
    ln -nfs "$SCRIPT_DIR/$folders/" "$folders"
    popd
done

# os
## MacOS
if [ "$(uname -s)" = "Darwin" ]; then
    export PLATFORM=MacOS
    printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Your platform is $PLATFORM"
    ./install/macos.sh

## Ubuntu
elif [ -f /etc/lsb-release ] && ( type apt > /dev/null 2>&1 ); then
    export PLATFORM=Ubuntu
    printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Your platform is $PLATFORM"
    ./install/apt.sh
else
    printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Your platform is not supported (yet)"
fi

# anyenv
if ! [ -d "$HOME/.anyenv" ]; then
    printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Installing anyenv..."
    git clone https://github.com/anyenv/anyenv "$HOME/.anyenv"
fi

export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init - zsh)"

if ! [ -d "$HOME/.config/anyenv/anyenv-install" ]; then
    echo y | anyenv install --init
fi

## anyenv-update
if ! [ -d "$(anyenv root)/plugins/anyenv-update" ]; then
    printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Installing anyenv-update..."
    mkdir -p "$(anyenv root)/plugins"
    git clone https://github.com/znz/anyenv-update.git "$(anyenv root)/plugins/anyenv-update"
fi

# plenv
if ! [ -d "$(anyenv root)/envs/plenv" ]; then
    printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Installing plenv..."
    anyenv install plenv
    eval "$(anyenv init - zsh)"
    plenv install-cpanm
fi

# perl with plenv
if ! [ -d "$(plenv root)"/versions/* ]; then
    printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Installing perl with plenv..."
    plenv install "$(curl -fsSL https://raw.githubusercontent.com/docker-library/official-images/master/library/perl | grep -i latest | awk '{ print $2 }' | sed -e 's/,//')"
fi

# docker
if [[ "$PLATFORM" != "MacOS" ]]; then
    printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Installing docker..."
    curl -fsSL https://get.docker.com | sh
fi

# rustup
printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Installing rustup..."
curl https://sh.rustup.rs -sSf | sh -s -- -y
source "$HOME/.cargo/env"
rustup update

# cargo
printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Installing $CARGO_INSTALL with cargo..."
cargo install sccache
export RUSTC_WRAPPER=$(which sccache); cargo install $CARGO_INSTALL

popd

printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Finished all script"

exit 0
