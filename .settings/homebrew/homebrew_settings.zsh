# Homebrew
export APPLE_HOMEBREW_PATH="/opt/homebrew"
eval "$($APPLE_HOMEBREW_PATH/bin/brew shellenv)"
alias brew="PATH='$APPLE_HOMEBREW_PATH/bin:$APPLE_HOMEBREW_PATH/sbin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/sbin' brew"
## extentions
FPATH=$APPLE_HOMEBREW_PATH/share/zsh/site-functions:$FPATH

# openssl
export PATH="$APPLE_HOMEBREW_PATH/opt/openssl@1.1/bin:$PATH"
# export LDFLAGS="-L$APPLE_HOMEBREW_PATH/opt/openssl@1.1/lib"
# export CPPFLAGS="-I$APPLE_HOMEBREW_PATH/opt/openssl@1.1/include"

# openldap
export PATH="$APPLE_HOMEBREW_PATH/opt/openldap/bin:$PATH"
export PATH="$APPLE_HOMEBREW_PATH/opt/openldap/sbin:$PATH"
# export LDFLAGS="-L$APPLE_HOMEBREW_PATH/opt/openldap/lib"
# export CPPFLAGS="-I$APPLE_HOMEBREW_PATH/opt/openldap/include"

# curl
export PATH="$APPLE_HOMEBREW_PATH/opt/curl/bin:$PATH"
FPATH=$APPLE_HOMEBREW_PATH/opt/curl/share/zsh/site-functions:$FPATH
# export LDFLAGS="-L$APPLE_HOMEBREW_PATH/opt/curl/lib"
# export CPPFLAGS="-I$APPLE_HOMEBREW_PATH/opt/curl/include"
# export PKG_CONFIG_PATH="$APPLE_HOMEBREW_PATH/opt/curl/lib/pkgconfig"

# perl
# PERL_MM_OPT="INSTALL_BASE=$HOME/perl5" cpan local::lib
# eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"

# readline
# export LDFLAGS="-L$APPLE_HOMEBREW_PATH/opt/readline/lib"
# export CPPFLAGS="-I$APPLE_HOMEBREW_PATH/opt/readline/include"

# sqlite
export PATH="$APPLE_HOMEBREW_PATH/opt/sqlite/bin:$PATH"
# export LDFLAGS="-L$APPLE_HOMEBREW_PATH/opt/sqlite/lib"
# export CPPFLAGS="-I$APPLE_HOMEBREW_PATH/opt/sqlite/include"
# export PKG_CONFIG_PATH="$APPLE_HOMEBREW_PATH/opt/sqlite/lib/pkgconfig"

# python@3.9
export PATH="$APPLE_HOMEBREW_PATH/opt/python@3.9/libexec/bin:$PATH"
# $APPLE_HOMEBREW_PATH/lib/python3.9/site-packages

# ruby
export PATH="$APPLE_HOMEBREW_PATH/lib/ruby/gems/3.0.0/bin:$PATH"
export PATH="$APPLE_HOMEBREW_PATH/opt/ruby/bin:$PATH"
# export LDFLAGS="-L$APPLE_HOMEBREW_PATH/opt/ruby/lib"
# export CPPFLAGS="-I$APPLE_HOMEBREW_PATH/opt/ruby/include"
# export PKG_CONFIG_PATH="$APPLE_HOMEBREW_PATH/opt/ruby/lib/pkgconfig"

# libffi
# export LDFLAGS="-L$APPLE_HOMEBREW_PATH/opt/libffi/lib"
# export CPPFLAGS="-I$APPLE_HOMEBREW_PATH/opt/libffi/include"
# export PKG_CONFIG_PATH="$APPLE_HOMEBREW_PATH/opt/libffi/lib/pkgconfig"

# m4
export PATH="$APPLE_HOMEBREW_PATH/opt/m4/bin:$PATH"

# libtool
# In order to prevent conflicts with Apple's own libtool we have prepended a "g"
# so, you have instead: glibtool and glibtoolize.

# guile
# Guile libraries can now be installed here:
#     Source files: $APPLE_HOMEBREW_PATH/share/guile/site/3.0
#   Compiled files: $APPLE_HOMEBREW_PATH/lib/guile/3.0/site-ccache
#       Extensions: $APPLE_HOMEBREW_PATH/lib/guile/3.0/extensions
# Add the following to your .bashrc or equivalent:
export GUILE_LOAD_PATH="$APPLE_HOMEBREW_PATH/share/guile/site/3.0"
export GUILE_LOAD_COMPILED_PATH="$APPLE_HOMEBREW_PATH/lib/guile/3.0/site-ccache"
export GUILE_SYSTEM_EXTENSIONS_PATH="$APPLE_HOMEBREW_PATH/lib/guile/3.0/extensions"

# gnutls
# If you are going to use the Guile bindings you will need to add the following to your .bashrc or equivalent in order for Guile to find the TLS certificates database:
export GUILE_TLS_CERTIFICATE_DIRECTORY="$APPLE_HOMEBREW_PATH/etc/gnutls/"

# icu4c
export PATH="$APPLE_HOMEBREW_PATH/opt/icu4c/bin:$PATH"
export PATH="$APPLE_HOMEBREW_PATH/opt/icu4c/sbin:$PATH"
# export LDFLAGS="-L$APPLE_HOMEBREW_PATH/opt/icu4c/lib"
# export CPPFLAGS="-I$APPLE_HOMEBREW_PATH/opt/icu4c/include"
# export PKG_CONFIG_PATH="$APPLE_HOMEBREW_PATH/opt/icu4c/lib/pkgconfig"

# tesseract
# This formula contains only the "eng", "osd", and "snum" language data files.
# If you need any other supported languages, run `brew install tesseract-lang`.

# nurses
export PATH="$APPLE_HOMEBREW_PATH/opt/ncurses/bin:$PATH"
# export LDFLAGS="-L$APPLE_HOMEBREW_PATH/opt/ncurses/lib"
# export CPPFLAGS="-I$APPLE_HOMEBREW_PATH/opt/ncurses/include"
# export PKG_CONFIG_PATH="$APPLE_HOMEBREW_PATH/opt/ncurses/lib/pkgconfig"

# tmux
# $APPLE_HOMEBREW_PATH/opt/tmux/share/tmux

# make
PATH="$APPLE_HOMEBREW_PATH/opt/make/libexec/gnubin:$PATH"

# git
# Emacs Lisp files have been installed to:
#   /opt/homebrew/share/emacs/site-lisp/git
