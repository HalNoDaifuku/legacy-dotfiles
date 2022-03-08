#!/bin/zsh

set -eu


# export
export SCRIPT_DIR=$(cd $(dirname $0); pwd)
export INSTALL_DIR="$HOME"
export LINK_FILES="
.config/starship.toml
.sheldon/plugins.toml
.gitconfig
.tmux.conf
.vimrc
.zshrc
"
export LINK_FOLDERS="
.settings
"
## color
export PRINTF_CYAN="\033[1;36m%s"
export PRINTF_DELETE_LINE="\033[m\n"

export LINK_FILES=$(echo "$LINK_FILES" | tr "\n" " ")
export LINK_FOLDERS=$(echo "$LINK_FOLDERS" | tr "\n" " ")

pushd "$SCRIPT_DIR"


# Symbolic link
## files
printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Linking files..."

/bin/sh -c '
for files in $LINK_FILES
do
    echo $files
    mkdir -p $INSTALL_DIR/"$(dirname $files)"
    ln -nfs "$SCRIPT_DIR/$files" "$INSTALL_DIR/$files"
done
'

## folders
printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Linking folders..."

/bin/sh -c '
for folders in $LINK_FOLDERS
do
    echo $folders
    mkdir -p $INSTALL_DIR/"$(dirname $folders)"
    ln -nfs "$SCRIPT_DIR/$folders/" "$INSTALL_DIR/$folders"
done
'

ls -a --color=auto $HOME

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

## Debian
elif [ -f /etc/debian_version ] && ( type apt > /dev/null 2>&1 ); then
    export PLATFORM=Debian
    printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Your platform is $PLATFORM"
    ./install/apt.sh
else
    printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Your platform is not supported (yet)"
fi


# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install bat cargo-binutils cargo-outdated cargo-update

popd

exit 0
