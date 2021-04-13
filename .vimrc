"<----------- UI/Visual ----------------->

"use 256 colors in screen/tmux
if &term == "screen"
  set t_Co=256
endif
"show line numbers, relative to current line
set number
set relativenumber
"show column/row
set ruler
"enable syntax highlight
syntax enable
"enable search term highlight
set hlsearch

"show name of program in vim when in tmux
if exists('$TMUX')
    autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window 'vim|" . expand("%:t") . "'")
endif

"<----------- Key Maps ----------------->

"keymaps for navigating splits
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

"Toggle paste mode with F4 
nmap <silent> <F4> :set invpaste<CR>:set paste?<CR>
imap <silent> <F4> <ESC>:set invpaste<CR>:set paste?<CR>

"Toggle line nos with F12
noremap <silent> <F6> :set number!<CR> :set relativenumber!<CR>;

"allow j/k to move between wrapped lines isntead of skipping
nmap j gj
nmap k gk

"<----------- Misc Usability  ----------------->

"enable mouse scrolling
set mouse=a
if !has('nvim')
    set ttymouse=sgr
endif

"tab = 4 spaces
set expandtab
set softtabstop=4
set tabstop=4
set shiftwidth=4

"allow backpace multiple lines in insert mode
set backspace=indent,eol,start

"always show x lines on either side of the cursor
set scrolloff=5

"scroll before pressing enter in search
set incsearch

"don't break in the middle of words
set linebreak

"put backups in ~/.vim/backup
set backupdir=~/.vim/backup
"put swap in ~/.vim/swap
set directory=~/.vim/swap

"ignore case when searching unless i use a capital
set ignorecase
set smartcase

"allow selecting empty space in visual block mode
set virtualedit=block

"make tab autocomplete more bash like
set wildmode=longest,list

"make splits open to the right or below current split
set splitbelow
set splitright

"auto reload changed files 
set autoread

"use + register as system clipboard
set clipboard=unnamed,unnamedplus

set fileformat=unix
set fileformats=unix,dos
