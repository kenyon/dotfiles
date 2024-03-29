#!/bin/zsh
# vim: filetype=zsh tabstop=8 shiftwidth=4 expandtab

# Purpose of this file, .zshenv: set path, important environment
# variables. Do not produce output.

umask 022

#### OPTIONS

setopt EMACS
setopt CORRECT DVORAK
setopt INTERACTIVE_COMMENTS
setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS
setopt PATH_DIRS
setopt PROMPT_SUBST
setopt EXTENDED_GLOB
# completion options
setopt ALWAYS_TO_END COMPLETE_IN_WORD LIST_PACKED NO_NOMATCH
# history options
setopt SHARE_HISTORY EXTENDED_HISTORY HIST_IGNORE_ALL_DUPS HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_NO_STORE HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS HIST_EXPIRE_DUPS_FIRST HIST_VERIFY

#### ENVIRONMENT VARIABLES

export PWGPG=~/Documents/passwords.gpg

export ALTERNATE_EDITOR=
export EDITOR='emacsclient --tty'
export EMAIL='kenyon@kenyonralph.com'
export LC_ALL=en_US.UTF-8
export LESS="--LONG-PROMPT --ignore-case --RAW-CONTROL-CHARS --HILITE-UNREAD"
export MAIL=~/Maildir/
export MAILCHECK=0
export MANWIDTH=${MANWIDTH:-80}
export PAGER=less
export SUDO_PROMPT='[sudo] password for %u@%H: '
export VISUAL="$EDITOR"

# colors in less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

#### PATHS

# Put the pre-existing path at the end.
path=( ~/bin \
    ~/Library/Python/*/bin \
    ~/.local/bin \
    ~/.gem/ruby/*/bin \
    ~/.local/share/gem/ruby/*/bin \
    ~/go/bin \
    /opt/puppetlabs/bin \
    /opt/local/sbin \
    /opt/local/bin \
    /usr/local/sbin \
    /usr/local/bin \
    /usr/local/bin/X11 \
    /usr/sbin \
    /usr/bin \
    /sbin \
    /bin \
    /usr/X11/bin \
    /usr/games \
    $path
)

if [[ -x /usr/local/opt/ruby/bin/gem ]]
then
    path=( $path $(/usr/local/opt/ruby/bin/gem environment gemdir)/bin )
fi

fpath=( ~/{.puppet-managed,git}/dotfiles/zshfuncs $fpath )

#### SOME HOST-SPECIFIC STUFF

if uname | grep -qi linux
then
    export DEB_BUILD_OPTIONS=parallel=$(nproc)
fi

if uname | grep -qi cygwin
then
    export EDITOR=emacsclientw
    export VISUAL="$EDITOR"
fi

GPG_TTY=$(tty)
export GPG_TTY
