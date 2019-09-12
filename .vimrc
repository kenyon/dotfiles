set nocompatible

"set guifont=Terminus\ 10
"set guifont=Monaco\ 9,DejaVu\ Sans\ Mono\ 10
"set guifont=DejaVu\ Sans\ Mono\ 10
" for Mac OS X:
"set guifont=Monaco:h10.00

if &t_Co >= 256 || &term =~ "-256color" || has("gui_running")
    set t_Co=256
    colorscheme zenburn
else
    colorscheme default
    set background=dark
endif

map Q gq
map Y y$
cmap <C-g> <C-c>
cmap <S-Insert> <MiddleMouse>
imap <S-Insert> <MiddleMouse>
nmap <F5> :checktime<CR>

let g:GPGPreferSign = 1

syntax on
set autoindent
set autoread
set autowrite
set backspace=indent,eol,start
set cpoptions+=$v
set expandtab
set guicursor+=a:blinkon0
set guioptions-=T
set hidden
set history=50
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set list
set listchars=tab:>\ ,trail:-
set nojoinspaces
set nostartofline
set number
set numberwidth=1
set ruler
set shiftwidth=4
set shortmess+=a
set showcmd
set showmatch
set smartcase
set smarttab
set softtabstop=4
set statusline=[%n]\ %f\ [%{strlen(&fenc)?&fenc:'none'},%{&ff}]%m%r%y%=%c%V,%l/%L\ %p%%,%P
set visualbell
set wildignore=*.bak,*.o,*.e,*~ " wildmenu: ignore these extensions
set wildmenu

if has("autocmd")
    filetype plugin indent on

    augroup krvimrc
        au!
        autocmd FileType text setlocal textwidth=78

        " for format=flowed, see mutt manual
        " disabled as of 20090714; see muttrc for why.
        "autocmd FileType mail setlocal fo+=w

        " spell checking for emails
        autocmd FileType mail setlocal spell

        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal g`\"" |
            \ endif

    augroup END
endif
