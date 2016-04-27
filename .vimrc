set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"NERDTree
Plugin 'scrooloose/nerdTree'
"Airline Status Bar + Themes
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Ack.Vim
Plugin 'mileszs/ack.vim'

"YouCompleteMe
Plugin 'Valloric/YouCompleteMe'

"BufferGator
Plugin 'jeetsukumaran/vim-buffergator'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"<----------- UI/Visual ----------------->

"use 256 colors in screen/tmux
if &term == "screen"
  set t_Co=256
endif

"show line numbers
set number
"show column/row
set ruler
"enable syntax highlight
syntax enable

"<----------- Key Maps ----------------->

"keymaps for navigating splits
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

"F2 = find in files
map <F2> :execute "Ack"<CR>

" Toggle paste mode with F4 
 nmap <silent> <F4> :set invpaste<CR>:set paste?<CR>
 imap <silent> <F4> <ESC>:set invpaste<CR>:set paste?<CR>

"enable nerdtree with Leader - N
nmap <leader>n :NERDTreeToggle<CR>

"enable buffergator with leader b - must be run AFTER plugin loads
"nmap <leader>b :BuffergatorToggle<CR>

"allow j/k to move between wrapped lines isntead of skipping
nmap j gj
nmap k gk

"<----------- Misc Usability  ----------------->

"enable mouse scrolling
set mouse=a
set ttymouse=sgr

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
set smartcase

"allow selecting empty space in visual block mode
set virtualedit=block

"make tab autocomplete more bash like
set wildmode=longest,list

"make splits open to the right or below current split
set splitbelow
set splitright

"<----------- Plugin Specific  ----------------->

"youcompleteme needs this to work
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"

" always show airline
set laststatus=2
" use powerline fonts
let g:airline_powerline_fonts = 1

