# vim

Command line text editor.

## dot files

Configuration file known as `.vimrc` created in the user's home directory.

```bash
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           ~/.vimrc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Inspired by:
"       https://github.com/amix/vimrc
"
" zo - open single fold at cursor
" zc - close single fold at cursor
" zR - open all folds
" zM - close all folds
" zf - creates new fold at cursor
" zd - delete fold at cursor
" zi - toggle on/off folding
" :help folding
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ------------------------- GENERAL ----------------------- {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Lines of history remembered
set history=1000

" Disable compatibility with vi for unexpected issues
set nocompatible

" Enable file type detection
filetype on
filetype indent on
filetype plugin on

" Enable syntax highlighting
syntax on

" Enable line numbers
set number

" Autoread when file is changed from outside
set autoread
au FocusGained,BuffEnter * checktime

" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ------------------------- INTERFACE --------------------- {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set lines to cursor when moving veritically using j/k
set so=7

" Avoid Chinese lang characters in Windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Set utf8 encoding en_US language
set encoding=utf8

" Use Unix as standard file type
set ffs=unix,dos,mac

" Enable Wild menu (auto complete)
set wildmenu
set wildmode=list:longest

" Ignore compiled and other files
set wildignore=*.o,*~,*.pyc,*.docx,*.jpg,*.png,*.gif,
        *.pdf,*.exe,*.flv,*.img,*.xlsx
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Always show current position
set ruler

" Height of command bar
set cmdheight=1

" Show partial command you type in last line of screen
set showcmd

" Show the mode you are in on last line of screen
set showmode

" Abandoned buffer becomes hidden
set hid

" Configure backspace to act as it should
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching and try to be smart
set ignorecase
set smartcase

" Highlight search results
set hlsearch

" Make search act like search in modern browsers (incremental highlighting)
set incsearch

" Don't redraw while executing macros (better performance)
set lazyredraw

" For regex
set magic
set regexengine=0

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" Disable error sounds
set noerrorbells
"set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Add a bit extra margin to the left
set foldcolumn=1

" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ---------------- FILES, BACKUPS, TABs/SPACES ------------ {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn off backups most stuff in SVN, git, etc.
set nobackup
set nowb
set noswapfile

" Do not let cursor scroll above or below number of lines
set scrolloff=10

" Use spaces instead of tabs and be smart
set expandtab
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Wrap text, line break, column highlight
set textwidth=80
set wrap
set colmuns=80
set colorcolumn=81,161,241,321,401,481,561,641,721,801
set highlight colorcolumn
set ctermbg=grey

" Auto and smart indent
set ai
set si

" }}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" -------------------------- PLUGINS ---------------------- {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" }}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" -------------------------- MAPPINGS --------------------- {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Map leader key combinations
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo save to handle permission-denied error
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" }}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ------------------------- VIMSCRIPT --------------------- {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable code folding using marker method
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" }}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ------------------------ STATUS LINE -------------------- {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" }}}

```

