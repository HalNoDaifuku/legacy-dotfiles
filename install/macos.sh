#!/usr/bin/env bash

set -eu


# XCode Command Line Tools
if [ ! -d "/Library/Developer/CommandLineTools" ] || [ ! -d "/Applications/Xcode.app/Contents/Developer" ]; then
    printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Installing XCode Command Line Tools..."
    xcode-select --install
fi


# Homebrew
if ! type brew > /dev/null 2>&1; then
    printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

## Brewfile
pushd .settings/homebrew

printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "Installing Homebrew packages..."
brew bundle -v

popd


# end
printf "$PRINTF_CYAN $PRINTF_DELETE_LINE" "End MacOS script"
