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
set lbr
set tw=100
set wrap
set colorcolumn=101,201,301,401,501,601,701,801,901,1001
set hl-colorcolumn ctermbg=238

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

" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Spellcheck shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z= 

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" }}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ------------------------- VIMSCRIPT --------------------- {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable code folding using marker method
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" }}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ------------------------ STATUS LINE -------------------- {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" }}}

```

