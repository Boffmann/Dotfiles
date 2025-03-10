set nocompatible            " disable compatibility to old-time vi
filetype plugin indent on   " allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set number                  " add line numbers
set relativenumber

set hidden
set hlsearch                " highlight search 
set incsearch               " incremental search
set ignorecase              " case insensitive 
set showmatch               " show matching 

set expandtab               " converts tabs to white space
set tabstop=2               " number of columns occupied by a tab 
set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
set shiftwidth=2            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed

" set mouse=v                 " middle-click paste with 
" set wildmode=longest,list   " get bash-like tab completions
" set cc=80                  " set an 80 column border for good coding style
" set mouse=a                 " enable mouse click
" set clipboard=unnamedplus   " using system clipboard
" filetype plugin on
" set cursorline              " highlight current cursorline
" set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download language package)
" set noswapfile            " disable creating swap file
" set backupdir=~/.cache/vim " Directory to store backup files.
