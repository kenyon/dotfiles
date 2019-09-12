# $FreeBSD: stable/8/share/skel/dot.cshrc 170119 2007-05-29 22:07:57Z dougb $
#
# .cshrc - csh resource script, read at beginning of execution by each shell
#
# see also csh(1), environ(7).
#

alias h		history 25
alias j		jobs -l
alias ls	ls -FGh
alias la	ls -aFGh
alias lf	ls -FAGh
alias ll	ls -laGhF
alias df	df -h
alias du	du -h
alias rm	rm -vi
alias rmdir	rmdir -v
alias mv	mv -vi
alias cp	cp -vi
alias ln	ln -ivw
alias mkdir	mkdir -v
alias chgrp	chgrp -v
alias chmod	chmod -v
alias chown	chown -v
alias chflags	chflags -v

# A righteous umask
umask 22

set path = (/sbin /bin /usr/sbin /usr/bin /usr/games /usr/local/sbin /usr/local/bin $HOME/bin)

setenv	EDITOR	vi
setenv	VISUAL	vi
setenv	PAGER	less
setenv	BLOCKSIZE	K
setenv  LESS 	-MiR
setenv  CLICOLOR	1

setenv CCACHE_DIR /var/db/ccache

if ($?prompt) then
	# An interactive shell -- set some stuff up
	set prompt = '%B%n%b@%m %~ %# '
	set filec
	set history = 100
	set savehist = 100
	set mail = (/var/mail/$USER)
	set nobeep
	if ( $?tcsh ) then
		bindkey "^W" backward-delete-word
		bindkey -k up history-search-backward
		bindkey -k down history-search-forward
	endif

	if ($TERM == konsole-256color) then
		setenv TERM xterm-256color
	endif
endif
