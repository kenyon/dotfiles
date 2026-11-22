# Zsh profile file, sourced for login shells.

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

[[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
