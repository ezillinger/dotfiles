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
""toggle nerdtree 
nmap <leader>n :NERDTreeToggle<CR>

"Airline Status Bar + Themes + TmuxLine
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'edkolev/tmuxline.vim'

"NeoComplete
Bundle 'Shougo/neocomplete.vim'

"BufferGator
Plugin 'jeetsukumaran/vim-buffergator'

"TagBar
Plugin 'majutsushi/tagbar'

"Ctrlsf (ack powered serach)
Bundle 'dyng/ctrlsf.vim'
nmap <leader>f <Plug>CtrlSFPrompt<CR>

"file-line (opens filename:linenumber output from grep)
Bundle 'bogado/file-line'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

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

"<----------- Key Maps ----------------->

"keymaps for navigating splits
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

"Toggle paste mode with F4 
nmap <silent> <F4> :set invpaste<CR>:set paste?<CR>
imap <silent> <F4> <ESC>:set invpaste<CR>:set paste?<CR>

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

"use w!! to write as root
cmap w!! w !sudo tee > /dev/null %
"<----------- Plugin Specific  ----------------->

"########### AIRLINE #############
" always show airline
set laststatus=2
" use powerline fonts
let g:airline_powerline_fonts = 1
let g:airline_theme='base16_atelierlakeside'

"########### NEOCOMPLETE #############
"neocomplete
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : ''
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
"inoremap <expr><C-g>     neocomplete#undo_completion()
"inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

