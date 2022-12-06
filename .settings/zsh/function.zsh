if type bat > /dev/null 2>&1; then
    function cat() {
        command cat $@ | bat --paging=never --plain
    }
fi

function winetricks() {
    if [ "$(uname -s)" = "Darwin" ]; then
        printf "\033[1;36m%s \033[m\n" "MacOS winetricks"
        sh -c "$(curl -fsSL $(curl -fsSL https://raw.githubusercontent.com/Gcenx/WineskinServer/master/WineskinWinetricks/Location.txt))" -c $@
    else
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks)" -c $@
    fi
}

function update-all() {
    if type brew > /dev/null 2>&1; then
        brew upgrade --greedy
    fi

    if type ibrew > /dev/null 2>&1; then
        ibrew upgrade --greedy
    fi

    if type apt-fast > /dev/null 2>&1; then
        sudo apt-fast update && sudo apt-fast dist-upgrade
    fi

    if type asdf > /dev/null 2>&1; then
        asdf plugin update --all
    fi

    if type anyenv > /dev/null 2>&1; then
        anyenv update -v
    fi

    if type mas > /dev/null 2>&1; then
        mas upgrade
    fi

    if type vim > /dev/null 2>&1; then
        vim -c "call dein#update() | q"
    fi

    if type pip-review > /dev/null 2>&1; then
        pip-review -v -a
    fi

    if type rustup > /dev/null 2>&1; then
        rustup update
    fi

    if type cargo-install-update > /dev/null 2>&1; then
        cargo install-update --all --git
    fi

    if type sheldon > /dev/null 2>&1; then
        sheldon source --update
    fi

    if type perl > /dev/null 2>&1; then
        perl -MCPAN -e "CPAN::Shell->install(CPAN::Shell->r)"
    fi
}
