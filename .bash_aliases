#!/bin/bash

# standard aliases
if type -P vim &> /dev/null
then
    alias vim='vim -X'
    alias vi='vim'
fi

if type -P rename &> /dev/null
then
    alias rename='rename --verbose'
fi

LS_OPTIONS='--color=auto --classify --human-readable'
alias aoeu='echo us;setxkbmap us'
alias asdf='echo dvorak;setxkbmap dvorak'
alias bc='bc -l'
alias chcon='chcon --verbose'
alias chgrp='chgrp --changes'
alias chmod='chmod --changes'
alias chown='chown --changes'
alias cp='cp --verbose --interactive'
alias df='df --human-readable'
alias dscverify='dscverify --keyring ~/.gnupg/pubring.gpg'
alias du='du --human-readable'
alias e='emacsclient --create-frame --alternate-editor='
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l="ls $LS_OPTIONS --almost-all"
alias ll="ls $LS_OPTIONS --format=long --all"
alias ln='ln --verbose --interactive'
alias ls="ls $LS_OPTIONS"
alias mdstat='cat /proc/mdstat'
alias mkdir='mkdir --verbose'
alias mv='mv --verbose --interactive'
alias pwed="vim $PWGPG"
alias pwview="view $PWGPG"
alias rm='rm --verbose --interactive'
alias rmdir='rmdir --verbose'
alias sg='sudo git'

# OS-specific aliases
case $(uname) in
    Darwin)
	LS_OPTIONS='-FGh'
	alias chgrp='chgrp -v'
	alias chmod='chmod -v'
	alias chown='chown -v'
	alias cp='cp -iv'
	alias ll="ls $LS_OPTIONS -la"
	alias l="ls $LS_OPTIONS -CFA"
	alias ln='ln -iv'
	alias ls="ls $LS_OPTIONS"
	alias mkdir='mkdir -v'
	alias mv='mv -iv'
	alias rmdir='rmdir -v'
	alias rm='rm -iv'
    ;;

    FreeBSD)
	LS_OPTIONS='-FGh'
	alias chflags='chflags -v'
	alias chgrp='chgrp -v'
	alias chmod='chmod -v'
	alias chown='chown -v'
	alias cp='cp -iv'
	alias ll="ls $LS_OPTIONS -la"
	alias l="ls $LS_OPTIONS -CFA"
	alias ln='ln -ivw'
	alias ls="ls $LS_OPTIONS"
	alias mkdir='mkdir -v'
	alias mv='mv -iv'
	alias rmdir='rmdir -v'
	alias rm='rm -iv'
    ;;

    SunOS)
	LS_OPTIONS='-Fh'
	alias cp='cp -i'
	alias ll="ls $LS_OPTIONS -la"
	alias l="ls $LS_OPTIONS -CFA"
	alias ls="ls $LS_OPTIONS"
	alias mkdir='mkdir'
	alias mv='mv -i'
	alias rm='rm -i'

	unalias chgrp
	unalias chmod
	unalias chown
	unalias chcon
	unalias ln
	unalias mdstat
	unalias rmdir
    ;;
esac
