"No compatible, and temporarily turn off filetype
set nocompatible
filetype off

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
set cmdheight=2

"Backspace behavior
set backspace=2

"Use mouse
set mouse=a

"No bells
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
"Required for Vundle use
Plugin 'gmarik/Vundle.vim'

"Sleek status line
Plugin 'bling/vim-airline'
"Code completion with <TAB>
Plugin 'ervandew/supertab'
"File explorer
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
"Buffer handling
"Plugin 'mattdbridges/bufkill.vim'
"Unite
Plugin 'Shougo/unite.vim'
"Giant collection of colorschemes
Plugin 'flazz/vim-colorschemes'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-colorscheme-switcher'
"Start page
Plugin 'mhinz/vim-startify'
"Improved syntax highlighting
Plugin 'd3vas3m/Improved-Syntax-Highlighting-Vim'
"Plugin 'hdima/python-syntax'
"Trailing whitespace
Plugin 'ntpeters/vim-better-whitespace'
if v:version >= 703
    "Press w to go
    Plugin 'Lokaltog/vim-easymotion'
    "Visual undo tree
    Plugin 'sjl/gundo.vim'
endif

if vundleStat == 0
	:PluginInstall
endif
call vundle#end()
filetype plugin indent on

"Plugin Config

"Airline
set ttimeoutlen=50
"Show whitespace
let g:airline#extensions#whitespace#enabled = 0
"Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
"Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
"No > or <
let g:airline_left_sep=''
let g:airline_right_sep=''

"Nerdtree
"if just called as vim, start NERDTree as well
"autocmd vimenter * if !argc() | NERDTree | endif
"if just NERDTree left, quit
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeWinSize=20

"Unite
"call unite#filters#matcher_default#use(['matcher_fuzzy'])
"call unite#filters#sorter_default#use(['sorter_rank'])

if v:version >= 703
    if has('python')
        "Gundo
        let g:gundo_width=20
    endif
endif

"Refresh syntax from the start
autocmd BufEnter * :syntax sync fromstart
command Sync syntax sync fromstart

"Set <leader> from '\' to ' '
let mapleader=" "

"Buffers
nmap <leader>t :enew!<CR>
nmap <leader>k :bnext!<CR>
nmap <leader>j :bprevious!<CR>
nmap <leader>x :bp <BAR> bd #<CR>

"Split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Common shortcuts
nmap <leader>w :w<CR>
nmap <leader>wq :wq<CR>
nmap <leader>q :q<CR>

"Nerdtree
"map <C-n> :NERDTreeToggle<CR>
nmap <leader>n :NERDTreeToggle<CR>

"Startify
nmap <leader>s :Startify<CR>
nmap <leader>ts :enew! <BAR> Startify<CR>

"Unite
nmap <leader>uf :Unite file -start-insert<CR>
nmap <leader>ub :Unite buffer<CR>

"CtrlP
nmap <leader>up :CtrlP<CR>

"Whitespace Toggle
nmap <leader><leader> :ToggleWhitespace<CR>

if v:version >= 703
    "Easymotion
    map \ <Plug>(easymotion-prefix)
    if has('python')
        "Gundo
        "nmap <leader>u :GundoToggle<CR>
        nnoremap <F5> :GundoToggle<CR>
    endif
endif

"Change directory to current file's
nmap <leader>cd :cd %:p:h<CR>

"Reload vimrc
nmap <leader>rc :so $MYVIMRC<CR>

"Cancel the search
nmap <leader>/ :nohl <BAR> let @/=""<CR>

"Paste toggle
set pastetoggle=<F10>
nmap <leader>p :set invpaste<CR>

"Syntax and colorscheme
syntax enable
set t_Co=256

"Conemu
if !empty($CONEMUBUILD)
    set term=xterm
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
    set background=dark
    let g:airline_theme='tomorrow'
    colorscheme Tomorrow-Night

"GUI Options
elseif has('gui_running')
    set t_Co=256
    set guifont=Lucida_Console:h10
    set background=dark
    let g:airline_theme='murmur'
    colorscheme Tomorrow-Night

"Windows commandline
elseif has('win32') || has('win64')
    "set t_Co=16
    set background=dark
    let g:airline_theme='murmur'
    "colorscheme solarized

"Probably Unix commandline
else
    set t_Co=256
    set background=dark
    let g:airline_theme='murmur'
    colorscheme Tomorrow-Night
endif

set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
