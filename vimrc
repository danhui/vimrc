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
Plugin 'sjl/gundo.vim'
Plugin 'ervandew/supertab'

call vundle#end()
filetype plugin indent on

"Airline
let g:airline_theme='murmur'
let g:airline#extensions#whitespace#enabled = 0

"Gundo
nnoremap <F5> :GundoToggle<CR>
