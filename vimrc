"No compatible, and temporarily turn off filetype
set nocompatible
filetype off

"Set 256 colour mode
set t_Co=256

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
autocmd GUIEnter * set vb t_vb=
autocmd VimEnter * set vb t_vb=

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
    if !filereadable($HOME."\\vimfiles\\bundle\\Vundle.vim\\README.md")
        silent call system("cd %USERPROFILE%")
	silent call system("mkdir %USERPROFILE%\\vimfiles\\bundle")
	silent call system("git clone https://github.com/gmarik/vundle %USERPROFILE%\\vimfiles\\bundle\\Vundle.vim")
	let vundleStat=0
    endif
    set rtp+=$HOME/vimfiles/bundle/Vundle.vim/
    silent call vundle#begin("$HOME/vimfiles/bundle/")
else
    let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
    if !filereadable(vundle_readme)
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/Vundle.vim
        let vundleStat=0
    endif
    set rtp+=$HOME/.vim/bundle/Vundle.vim
    call vundle#begin("$HOME/.vim/bundle/")
end
Plugin 'gmarik/Vundle.vim'

Plugin 'bling/vim-airline'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/nerdtree'
Plugin 'flazz/vim-colorschemes'
Plugin 'mhinz/vim-startify'
if v:version >= 703
    Plugin 'Lokaltog/vim-easymotion'
    Plugin 'sjl/gundo.vim'
endif

if vundleStat == 0
	:PluginInstall
endif
call vundle#end()
filetype plugin indent on

"Airline
set ttimeoutlen=50
"let g:airline_theme='murmur'
"Show whitespace
let g:airline#extensions#whitespace#enabled = 0
"Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
"Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

"Nerdtree
map <C-n> :NERDTreeToggle<CR>
"if just called as vim, start NERDTree as well
"autocmd vimenter * if !argc() | NERDTree | endif
"if just NERDTree left, quit
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

if v:version >= 703
    "<F5> for Gundo
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

"Syntax and colorscheme
syntax enable
if !empty($CONEMUBUILD)
    set term=xterm
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
endif
set background=dark
let g:airline_theme='murmur'
colorscheme distinguished

" GUI Options
if has('gui_running')
    set background=dark
    colorscheme distinguished
    set guifont=Lucida_Console:h10
    let g:airline_theme='murmur'
endif

"Show trailing whitespace
match Todo /\s\+$/
