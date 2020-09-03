#!/bin/zsh
# vim: filetype=zsh tabstop=8 shiftwidth=4 expandtab

# Purpose of this file, .zshrc: set up aliases, functions (although
# these are defined in $fpath), options, key bindings, etc.
# Interactive stuff.

zstyle :compinstall filename "$HOME/.zshrc"
zstyle ':completion:*' completer _complete _approximate
autoload -Uz compinit
compinit

#### ZSH INTERACTIVE VARIABLES

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
WORDCHARS=${WORDCHARS:s#/##:s/.//:s/-//:s/_//:s/*//:s/=//:s/&//}

#### ALIASES

# standard aliases
if whence -p vim &> /dev/null
then
    alias vim='vim -X'
    alias vi='vim'
fi

if whence -p rename &> /dev/null
then
    alias rename='rename --verbose'
fi

LS_OPTIONS='--color=auto --classify --human-readable'
alias aoeu='echo us;setxkbmap us'
alias asdf='echo dvorak;setxkbmap dvorak'
alias bc='bc --mathlib'
alias chcon='chcon --verbose'
alias chgrp='chgrp --changes'
alias chmod='chmod --changes'
alias chown='chown --changes'
alias cp='nocorrect cp --verbose --interactive'
alias df='df --human-readable'
alias dscverify='dscverify --keyring ~/.gnupg/pubring.gpg'
alias du='du --human-readable'
alias e='emacsclient --tty'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias free='free --total --human --wide'
alias gcal='gcal --starting-day=Monday'
alias grep='grep --color=auto'
alias l="ls $LS_OPTIONS --almost-all"
alias ll="ls $LS_OPTIONS --format=long --all"
alias ln='nocorrect ln --verbose --interactive'
alias ls="ls $LS_OPTIONS"
alias mdstat='cat /proc/mdstat'
alias mkdir='nocorrect mkdir --verbose'
alias mv='nocorrect mv --verbose --interactive'
alias pwed="vim $PWGPG"
alias pwview="view $PWGPG"
alias rm='nocorrect rm --verbose --interactive'
alias rmdir='nocorrect rmdir --verbose'

# OS-specific aliases
case $(uname -a) in
    *Darwin*)
        LS_OPTIONS='-FGh'
        alias chgrp='chgrp -v'
        alias chmod='chmod -v'
        alias chown='chown -v'
        alias cp='nocorrect cp -iv'
        alias df='df -h'
        alias du='du -h'
        alias l="ls $LS_OPTIONS -CFA"
        alias ll="ls $LS_OPTIONS -la"
        alias ln='nocorrect ln -iv'
        alias ls="ls $LS_OPTIONS"
        alias mkdir='nocorrect mkdir -v'
        alias mv='nocorrect mv -iv'
        alias rm='nocorrect rm -iv'
        unalias chcon
        unalias rmdir
    ;;

    *FreeBSD*)
        LS_OPTIONS='-FGh'
        alias chflags='chflags -v'
        alias chgrp='chgrp -v'
        alias chmod='chmod -v'
        alias chown='chown -v'
        alias cp='nocorrect cp -iv'
        alias df='df -h'
        alias du='du -h'
        alias l="ls $LS_OPTIONS -CFA"
        alias ll="ls $LS_OPTIONS -la"
        alias ln='nocorrect ln -ivw'
        alias ls="ls $LS_OPTIONS"
        alias mkdir='nocorrect mkdir -v'
        alias mv='nocorrect mv -iv'
        alias rm='nocorrect rm -iv'
        alias rmdir='nocorrect rmdir -v'
        alias spm='sudo portmaster'
    ;;

    *SunOS*)
        LS_OPTIONS='-Fh'
        alias cp='nocorrect cp -i'
        alias ll="ls $LS_OPTIONS -la"
        alias l="ls $LS_OPTIONS -CFA"
        alias ls="ls $LS_OPTIONS"
        alias mkdir='nocorrect mkdir'
        alias mv='nocorrect mv -i'
        alias rm='nocorrect rm -i'
        unalias chgrp
        unalias chmod
        unalias chown
        unalias chcon
        unalias ln
        unalias mdstat
        unalias rmdir
    ;;

    *Cygwin*)
        alias npp='notepad++'
    ;;
esac

#### ZSH INTERACTIVE STUFF

bindkey -e
autoload edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line

# From <http://zshwiki.org/home/zle/bindkeys>:
# create a zkbd compatible hash;
# to add other keys to this hash, see man 5 terminfo
typeset -g -A key

key[Home]="$terminfo[khome]"
key[End]="$terminfo[kend]"
key[Insert]="$terminfo[kich1]"
key[Backspace]="$terminfo[kbs]"
key[Delete]="$terminfo[kdch1]"
key[Up]="$terminfo[kcuu1]"
key[Down]="$terminfo[kcud1]"
key[Left]="$terminfo[kcub1]"
key[Right]="$terminfo[kcuf1]"
key[PageUp]="$terminfo[kpp]"
key[PageDown]="$terminfo[knp]"

# set up key accordingly
[[ -n "$key[Home]"      ]] && bindkey -- "$key[Home]"      beginning-of-line
[[ -n "$key[End]"       ]] && bindkey -- "$key[End]"       end-of-line
[[ -n "$key[Insert]"    ]] && bindkey -- "$key[Insert]"    overwrite-mode
[[ -n "$key[Backspace]" ]] && bindkey -- "$key[Backspace]" backward-delete-char
[[ -n "$key[Delete]"    ]] && bindkey -- "$key[Delete]"    delete-char
[[ -n "$key[Up]"        ]] && bindkey -- "$key[Up]"        up-line-or-history
[[ -n "$key[Down]"      ]] && bindkey -- "$key[Down]"      down-line-or-history
[[ -n "$key[Left]"      ]] && bindkey -- "$key[Left]"      backward-char
[[ -n "$key[Right]"     ]] && bindkey -- "$key[Right]"     forward-char

# Finally, make sure that the terminal is in application mode when zle
# is active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        echoti smkx
    }
    function zle-line-finish () {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# disable flow control. necessary for my ^s binding.
stty -ixon

# make less more friendly for non-text input files, see lesspipe(1)
if [[ -x /usr/bin/lesspipe ]] # Linux lesspipe
then
    eval "$(SHELL=/bin/sh lesspipe)"
elif [[ -x /usr/local/bin/lesspipe.sh ]] # FreeBSD lesspipe
then
    eval "$(SHELL=/bin/sh /usr/local/bin/lesspipe.sh)"
fi

# set colors for use in prompts
if autoload colors && colors 2>/dev/null
then
    BLUE="%{${fg[blue]}%}"
    RED="%{${fg_bold[red]}%}"
    GREEN="%{${fg[green]}%}"
    CYAN="%{${fg[cyan]}%}"
    MAGENTA="%{${fg[magenta]}%}"
    YELLOW="%{${fg[yellow]}%}"
    WHITE="%{${fg[white]}%}"
    NO_COLOUR="%{${reset_color}%}"
else
    BLUE=$'%{\e[1;34m%}'
    RED=$'%{\e[1;31m%}'
    GREEN=$'%{\e[1;32m%}'
    CYAN=$'%{\e[1;36m%}'
    WHITE=$'%{\e[1;37m%}'
    MAGENTA=$'%{\e[1;35m%}'
    YELLOW=$'%{\e[1;33m%}'
    NO_COLOUR=$'%{\e[0m%}'
fi

EXITCODE="%(?..%?%1v )"
PROMPT2='\`%_> '      # secondary prompt, printed when the shell needs more information to complete a command.
PROMPT3='?# '         # selection prompt used within a select loop.
PROMPT4='+%N:%i:%_> ' # the execution trace prompt (setopt xtrace). default: '+%N:%i>'

if whence -p dircolors &> /dev/null
then
    if [[ -r ~/.dircolors ]]
    then
        eval "$(dircolors ~/.dircolors)"
    else
        eval "$(dircolors)"
    fi
fi

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

#### FUNCTIONS

for f in ~/.puppet-managed/dotfiles/zshfuncs/*~(*.zwc|*~)
do
    autoload $f:t
done

[[ -r ~/.zshrc.local ]] && source ~/.zshrc.local

# remove duplicates from these arrays
typeset -U path cdpath fpath manpath

if uname | grep -qi cygwin
then
    export TERM=cygwin
fi

if [[ "$TERM" == "dumb" ]]
then
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
    PROMPT='$ '
else
    source ~/.puppet-managed/dotfiles/git-prompt.sh
    export GIT_PS1_SHOWDIRTYSTATE=true
    export GIT_PS1_SHOWSTASHSTATE=true
    export GIT_PS1_SHOWUNTRACKEDFILES=true
    export GIT_PS1_SHOWUPSTREAM="verbose"
    export GIT_PS1_SHOWCOLORHINTS=true

# The print command here sets the PuTTY or whatever terminal window title.
    precmd () {__git_ps1 '${RED}${EXITCODE}${WHITE}${BLUE}%n${NO_COLOUR}@%m %40<...<%B%~%b%<<' ' %{${fg_bold[green]}%}%#${NO_COLOUR} ' ; print -Pn "\e]0;%n@%m %~\a"}

    if whence -p keychain &> /dev/null
    then
        eval $(keychain --eval --nogui --ignore-missing --inherit any --systemd id_ed25519 id_rsa id_ecdsa)
    fi

    if whence -p fortune &> /dev/null
    then
        echo
        fortune -a
        echo
    fi
fi
