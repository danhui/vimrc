"Runtime path for Windows only
if has("win32") || has("win64")
    set rtp+=$HOME/vimfiles/bundle/Vundle.vim/
end

"No compatible, and temporarily turn off filetype
set nocompatible
filetype off

"Syntax and colorscheme
set t_Co=256
colorscheme distinguished
syntax enable

"Show line number
set number

"Show cursor position
set cursorline

"Casing
set ignorecase
set smartcase

"Spacing
set smarttab
set expandtab
set ai
set si
set wrap
set shiftwidth=4
set softtabstop=4

"Show trailing whitespace
match Todo /\s\+$/

"Always show status
set laststatus=2

"Backspace behavior
set backspace=2

"Use mouse
set mouse=a

"No sounds/error messages
set noerrorbells
set visualbell
set t_vb=

"Highlight search results
set hlsearch

"Show matching brackets
"set showmatch

"Pathogen
"execute pathogen#infect()
"filetype plugin indent on

"Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Plugin 'bling/vim-airline'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/nerdtree'
if v:version >= 703
    Plugin 'Lokaltog/vim-easymotion'
    Plugin 'sjl/gundo.vim'
endif

call vundle#end()
filetype plugin indent on

"Airline
set ttimeoutlen=50
let g:airline_theme='murmur'
let g:airline#extensions#whitespace#enabled = 0

"Nerdtree
map <C-n> :NERDTreeToggle<CR>
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

if v:version >= 703
    "Gundo
    nnoremap <F5> :GundoToggle<CR>
endif
