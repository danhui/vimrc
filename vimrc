"========================================================================
"Some general settings

"No compatible, and temporarily turn off filetype
set nocompatible
filetype off

"Show line number
if v:version >= 703
    set relativenumber
endif
set number

"Show cursor position
set cursorline

"Casing
set ignorecase
set smartcase

"Spacing
set smarttab
set expandtab
set wrap
set shiftwidth=4
set softtabstop=4

"Status bar
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

"Files to ignore
"Unix
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
"Windows
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.tmp

"========================================================================
"Plugin managers

"Pathogen
"execute pathogen#infect()
"filetype plugin indent on

"Vundle
"Here we check if Vundle needs to be installed
let vundleStat=1
"Windows
if has("win32") || has("win64")
    if !filereadable($HOME."\\vimfiles\\bundle\\Vundle.vim\\README.md")
        silent call system("cd %USERPROFILE%")
	silent call system("mkdir %USERPROFILE%\\vimfiles\\bundle")
	silent call system("git clone https://github.com/gmarik/vundle %USERPROFILE%\\vimfiles\\bundle\\Vundle.vim")
	let vundleStat=0
    endif
    set rtp+=$HOME/vimfiles/bundle/Vundle.vim/
    silent call vundle#begin("$HOME/vimfiles/bundle/")
"Linux
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

let g:pluginList = []

function! AppendPlugin(plugin)
    Plugin a:plugin
    let tmp = split(a:plugin, '/')
    let tmp = split(tmp[-1], '''')
    call add(g:pluginList, tmp[0])
endfunction

command! -nargs=1 AddPlugin call AppendPlugin(<f-args>)

function! HasPlugin(plugin)
    return index(g:pluginList, a:plugin) > -1
endfunction

"Required for Vundle use
AddPlugin 'gmarik/Vundle.vim'

"Sleek status line
AddPlugin 'bling/vim-airline'

"Code completion with <TAB>
AddPlugin 'ervandew/supertab'

"Surround
AddPlugin 'tpope/vim-surround'

"File explorer
"AddPlugin 'scrooloose/nerdtree'
AddPlugin 'kien/ctrlp.vim'
AddPlugin 'tacahiroy/ctrlp-funky'

"Buffer handling
"AddPlugin 'mattdbridges/bufkill.vim'

"Unite
AddPlugin 'Shougo/unite.vim'

"Giant collection of colorschemes
AddPlugin 'flazz/vim-colorschemes'
AddPlugin 'xolox/vim-misc'
AddPlugin 'xolox/vim-colorscheme-switcher'

"Start page
AddPlugin 'mhinz/vim-startify'

"Improved syntax highlighting
AddPlugin 'sheerun/vim-polyglot'
"AddPlugin 'd3vas3m/Improved-Syntax-Highlighting-Vim'
"AddPlugin 'hdima/python-syntax'

"Trailing whitespace
AddPlugin 'ntpeters/vim-better-whitespace'

"Indentation
AddPlugin 'nathanaelkane/vim-indent-guides'

if v:version >= 703
    "Press w to go
    AddPlugin 'Lokaltog/vim-easymotion'
    "Visual undo tree
    AddPlugin 'mbbill/undotree'
    if has('python')
        "AddPlugin 'sjl/gundo.vim'
        "Shell in vim
        "AddPlugin 'rosenfeld/conque-term'
    endif
endif

if vundleStat == 0
    PluginInstall
endif
call vundle#end()
filetype plugin indent on

"========================================================================
"Plugin Config

"Set <leader> from '\' to ' '
nnoremap <SPACE> <Nop>
let mapleader=" "

"Pane width (applies to drawers, e.g. Nerdtree, undo trees)
let paneWidth = 25

"Startify
if HasPlugin('vim-startify')
    let g:startify_skiplist = [
                    \ 'COMMIT_EDITMSG',
                    \ $VIMRUNTIME .'/doc',
                    \ 'bundle/.*/doc',
                    \ ]
    autocmd FileType startify setlocal buftype=
    nmap <leader>s :Startify<CR>
endif

"Airline
if HasPlugin('vim-airline')
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
endif

"Nerdtree
if HasPlugin('nerdtree')
    "if just called as vim, start NERDTree as well
    autocmd vimenter * if !argc() | NERDTree | endif
    "if just NERDTree left, quit
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
    let g:NERDTreeWinSize=paneWidth
    map <C-n> :NERDTreeToggle<CR>
    nmap <leader>n :NERDTreeToggle<CR>
endif

"CtrlP
    if HasPlugin('ctrlp.vim')
    let g:ctrlp_extensions = ['funky']
    let g:ctrlp_funky_syntax_highlight = 1
    let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn)$',
      \ 'file': '\v\.(exe|so|dll)$',
      \ 'link': 'some_bad_symbolic_links',
      \ }
    "nmap <C-P> :CtrlP<CR>
    nmap <C-F> :CtrlPFunky<CR>
    nmap <C-B> :CtrlPBuffer<CR>
endif

"Unite
if HasPlugin('unite.vim')
    "call unite#filters#matcher_default#use(['matcher_fuzzy'])
    "call unite#filters#sorter_default#use(['sorter_rank'])
    nmap <leader>uf :Unite file -start-insert -buffer-name="unite"<CR>
    "nmap <leader>ub :Unite buffer<CR>
endif

"Indentation Rules
if HasPlugin('vim-indent-guides')
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1
endif

"Whitespace
if HasPlugin('vim-better-whitespace')
    let g:better_whitespace_filetypes_blacklist=['unite']
    nmap <leader><leader> :ToggleWhitespace<CR>
endif

"Easymotion
if HasPlugin('vim-easymotion')
    " Disabled default mappings
    let g:EasyMotion_do_mapping = 0
    " Set easymotion key
    map \ <Plug>(easymotion-prefix)
    nmap <leader>l <Plug>(easymotion-bd-w)
    nmap <Plug>(easymotion-prefix)s <Plug>(easymotion-s2)
    nmap <Plug>(easymotion-prefix)w <Plug>(easymotion-w)
endif

"UndoTree
if HasPlugin('undotree')
    nnoremap <F5> :UndotreeToggle<CR>:AirlineRefresh<CR>
    let g:undotree_SplitWidth = paneWidth
    let g:undotree_SetFocusWhenToggle = 1
endif

"Conque
if HasPlugin('conque-term')
    let g:ConqueTerm_StartMessages = 0
    function! OnConqueEnter(term)
        DisableWhitespace
    endfunction
    function! OnConqueLeave(term)
        EnableWhitespace
    endfunction
    call conque_term#register_function('buffer_enter', 'OnConqueEnter')
    call conque_term#register_function('buffer_leave', 'OnConqueLeave')
    nmap <leader>cq :ConqueTermVSplit<SPACE>
endif

"Gundo
if HasPlugin('gundo.vim')
    nmap <leader>u :GundoToggle<CR>
    nnoremap <F5> :GundoToggle<CR>
    let g:gundo_width=paneWidth
endif

"========================================================================
"Other commands and shortcuts

"Refresh syntax from the start
autocmd BufEnter * syntax sync fromstart
function! SyntaxRefresh()
    syntax on
    syntax sync fromstart
endfunction
command! Sync call SyntaxRefresh()

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
nmap <leader>e :e<SPACE>

"Change directory to current file's
nmap <leader>cd :cd %:p:h<CR>

"Reload vimrc
nmap <leader>rc :so $MYVIMRC<CR>

"Clear the search
nmap <leader>/ :nohl <BAR> let @/=""<CR>

"Paste toggle
set pastetoggle=<F10>
nmap <leader>p :set invpaste<CR>

"========================================================================
"Syntax, fonts, themes, and colorscheme
syntax on
set t_Co=256

"GUI Options
if has('gui_running')
    set t_Co=256
    if has('win32') || has('win64')
        "set guifont=Consolas:h10
        set guifont=DejaVu_Sans_Mono:h10
    else
        set guifont=DejaVu\ Sans\ Mono\ 11
    endif
    set background=dark
    let g:airline_theme='tomorrow'
    colorscheme Tomorrow-Night

"Conemu
elseif !empty($CONEMUBUILD)
    set term=xterm
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
    set background=dark
    let g:airline_theme='tomorrow'
    colorscheme Tomorrow-Night

"Windows commandline
elseif has('win32') || has('win64')
    "set t_Co=16
    set background=dark
    let g:airline_theme='murmur'
    "colorscheme solarized

"Probably Unix commandline
else
    set clipboard=exclude:.*
    set t_Co=256
    set background=dark
    let g:airline_theme='murmur'
    colorscheme Tomorrow-Night
endif
