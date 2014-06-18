"No compatible, and temporarily turn off filetype
set nocompatible
filetype off

"Syntax and colorscheme
set t_Co=256
syntax enable
colorscheme distinguished

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
"Runtime path
let vundleStat=1
if has("win32") || has("win64")
	let vundle_readme=expand("~/vimfiles/bundle/Vundle.vim/README.md")
	if !filereadable(vundle_readme)
		silent !mkdir -p ~/vimfiles/bundle
		silent !git clone https://github.com/gmarik/vundle ~/vimfiles/bundle/Vundle.vim
		let vundleStat=0
	endif
	set rtp+=~/vimfiles/bundle/Vundle.vim/
	call vundle#begin("~/vimfiles/bundle/")
else
	let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
	if !filereadable(vundle_readme)
		silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/Vundle.vim
        let vundleStat=0
	endif
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin("~/.vim/bundle/")
end
Plugin 'gmarik/Vundle.vim'

Plugin 'bling/vim-airline'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/nerdtree'
if v:version >= 703
    Plugin 'Lokaltog/vim-easymotion'
    Plugin 'sjl/gundo.vim'
endif

if vundleStat == 0
	:BundleInstall
endif
call vundle#end()
filetype plugin indent on

"Airline
set ttimeoutlen=50
let g:airline_theme='murmur'
"Show whitespace
let g:airline#extensions#whitespace#enabled = 0
"Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
"Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

"Nerdtree
map <C-n> :NERDTreeToggle<CR>
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

if v:version >= 703
    "Gundo
    nnoremap <F5> :GundoToggle<CR>
endif

"Set <leader> from '\' to ' '
let mapleader=" "

"Buffers
" To open a new empty buffer
nmap <leader>t :enew<CR>
" Move to the next buffer
nmap <leader>j :bnext<CR>
" Move to the previous buffer
nmap <leader>k :bprevious<CR>
" " Close the current buffer and move to the previous one
nmap <leader>x :bp <BAR> bd #<CR>

"Common shortcuts
nmap <leader>w :w<CR>
nmap <leader>wq :wq<CR>
nmap <leader>q :q<CR>

"Nerdtree
nmap <leader>n :NERDTreeToggle<CR>
