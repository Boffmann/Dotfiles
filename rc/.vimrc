" Plugin Do not try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle Plugins
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-commentary'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'majutsushi/tagbar'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'christoomey/vim-system-copy'
Plugin 'morhetz/gruvbox'
Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-misc'
Plugin 'kien/ctrlp.vim'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'ycm-core/YouCompleteMe'
" Plugin 'tmhedberg/SimpylFold'
Plugin 'suan/vim-instant-markdown', {'rpt': 'after'}
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'sheerun/vim-polyglot'
Plugin 'terryma/vim-smooth-scroll'

"Plugin ReplaceWithRegister installed via airball

call vundle#end()

" For filetype plugins to load correctly
filetype plugin indent on

" Turn on syntax highlighting
syntax on
" Use old regex engine because new one slows down syntax highlighting
set re=1
" Set settings of vim-color-solarized
" set background=light
" let g:solarized_termcolors=256
" colorscheme solarized

" Colorscheme
colorscheme gruvbox
set background=dark

" Ariline theme
let g:airline_theme='bubblegum'

" Comment color
" :highlight Comment ctermfg=DarkGreen

" Security
set modelines=0

" Show abolute line number in current line and
" relative line numbers for every other line
set number
set relativenumber

" Show file stats
set ruler

" Allow hidden buffers
set hidden

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch

" ensure that the highlight group gets created and is not cleared by future
" colorscheme command
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
" Create highlight group
:highlight ExtraWhitespace ctermbg=red guibg=red
" Show trailing whitespace:
:match ExtraWhitespace /\s\+$/
" Switch off :match highlighting.
" :match
" Show ExtraWhitespace as soon as leaving insert mode
:au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
:au InsertLeave * match ExtraWhitespace /\s\+$/

" When a file has beed detected t ohave been changed outside of Vim, reload
set autoread

" Make spaces instead of tab
:set expandtab
" show existing tab with 4 spaces width
" :set tabstop=2
set softtabstop=2
" when indenting with '>', use 4 spaces width
:set shiftwidth=2
" special treatment for html files
autocmd BufRead,BufNewFile *.htm,*.html setlocal tabstop=2 shiftwidth=2 softtabstop=2

" Set directory to store and aggregate swp files in
set directory^=$HOME/.vim/tmp//

" Set leader key to ,
let mapleader=","

" NERDTree
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
let NERDTreeMapOpenInTab='<ENTER>'
nmap <F6> :NERDTreeToggle<CR>
" Close Vim if the only buffer that is left open is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Cpp highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

" tag options
" Create tags for class members as well
let g:easytags_include_members = 1
" store tags in specific tags directory
let g:easytags_file = '~/.vim/tags'
" Create seperate tags file for each filetype
let g:easytags_dynamic_files = 1
" Let Vim walk up directory hierarchy from CWD to root looking for tags file
" Tell EasyTags to use the tags file in the current project path. If not
" found, use global ~/.vimtag file
set tags=./tags;,tags;
let g:easytags_dynamic_files = 1
" Update Tags in background
let g:easytags_async = 1
" Always update tags when saving the file
let g:easytags_events = ['BufWritePost']
" Disable periodic updates
let g:easytags_on_cursorhold = 0
" Disable easytags syntax highlighting for python files (is done by bfrg/vim-cpp-modern)
autocmd FileType python let b:easytags_auto_highlight = 0
" Run :HightlightTags on startup
" autocmd execute command
" BufEnter: When buffer is loaded for first time
" * for all filetypes
autocmd BufEnter * :HighlightTags

" syntastic options
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_config_file = '.syntastic_cpp_config'
" Set python checker
let g:syntastic_python_checkers = ['pyflakes']
let g:syntastic_python_pyflakes_exe = 'python3 -m pyflakes'
" Do not check automatically when saving file. To invoke check run
" :SyntasticCheck
let g:syntastic_mode_map = {
  \ "mode": "passive",
  \ "active_filetypes": [],
  \ "passive_filetypes": [] }

" commentary options
" Set commentstring for cpp filetypes
autocmd FileType cpp setlocal commentstring=//%s

" CtrlP options
" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'ra'
" Use a leader instead of the actual named binding
nmap <leader>p :CtrlP<cr>
" Easy bindings for its various modes
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>

" Settings for markdown preview
" Start new window when editing markdown
let g:instant_markdown_browser = "google-chrome --new-window"
" Do not automatically trigger preview
let g:instant_markdown_autostart = 0

" delete without yanking
" nnoremap d "_d
" vnoremap d "_d

" replace currently selected text with default register
" without yanking it
vnoremap p "_dP


" YouCompleteMe
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_show_diagnostics_ui = 0
" Set global configuration file
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

"Buffergator
nmap <F7> :BuffergatorToggle<cr>
" automatically update view when buffer list changes
let g:buffergator_autoupdate = 1
" Sort buffers based on their names
let g:buffergator_sort_regime = "basename"

" Map keys for switching between split windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" More natural split opening
set splitbelow
set splitright
" Map keys to jump to tag
nnoremap t <C-]>
" tagbar
nmap <F5> :TagbarToggle<CR>
" Automatically close when selected tag
let g:tagbar_autoclose = 0
" open on left side
let g:tagbar_left = 0
" automatically focus when opened
let g:tagbar_autofocus = 1
" Show line numbers
let g:tagbar_show_linenumbers = 1
" remap jump to tag
" let g:tagbar_map_jump = "o"

" Vim Polyglot
" Disable individual language packs
let g:polyglot_disabled = ['markdown']

" Map scrolling to enable smooth scrolling
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 20, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 20, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 20, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 20, 4)<CR>

" Vim folding
" Fold methods
" set foldmethod=indent
" set foldlevel=1
" Use space in normal mode to toggle fold open/close.
" nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
" vnoremap <Space> zf

" Maps for workflow
" Replace all words (leader is \)
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
" Replace word under curser
" map <Leader>v ciw<C-R>0<ESC>
" Reread vimrc
nmap <silent> <leader>sv :so $MYVIMRC<CR>
nmap <silent> <leader>c<space> :SyntasticCheck<CR>

