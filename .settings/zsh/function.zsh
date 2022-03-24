# # apt-fast
# if type apt > /dev/null 2>&1; then
#     apt-fast() {
#         curl -fsSL 'https://raw.githubusercontent.com/ilikenwf/apt-fast/master/apt-fast' | bash -s -- $*
#     }
# fi

update-all() {
    if type brew > /dev/null 2>&1; then
        brew upgrade --greedy
    fi

    if type ibrew > /dev/null 2>&1; then
        ibrew upgrade --greedy
    fi

    if type apt-fast > /dev/null 2>&1; then
        sudo apt-fast update && sudo apt-fast dist-upgrade
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

    if type pip > /dev/null 2>&1; then
        pip list -o | tail -n +3 | awk "{ print $1 }" | xargs pip install -U
    fi

    if type pip3 > /dev/null 2>&1; then
        pip3 list -o | tail -n +3 | awk "{ print $1 }" | xargs pip3 install -U
    fi

    if type rustup > /dev/null 2>&1; then
        rustup update
    fi

    if type cargo-install-update > /dev/null 2>&1; then
        cargo install-update --all --git
    fi

    if type sheldon > /dev/null 2>&1; then
        sheldon lock --update
    fi

    if type perl > /dev/null 2>&1; then
        perl -MCPAN -e "CPAN::Shell->install(CPAN::Shell->r)"
    fi
}
