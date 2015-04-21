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

"Colorcolumn
if exists('+colorcolumn')
  set colorcolumn=80
endif

"Casing
set ignorecase
set smartcase

"Spacing
set smarttab
set expandtab
set shiftwidth=2
set tabstop=2

"Line wrapping
set nowrap

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

"Session options
set sessionoptions=buffers,curdir

"Persistant history
set undofile
set undolevels=1000
set undoreload=10000
if has("win32") || has("win64")
  if !isdirectory(expand($HOME."\\vimfiles\\undo"))
    silent call system("mkdir ".$HOME."\\vimfiles\\undo")
  end
  set undodir=$HOME/vimfiles/undo
else
  if !isdirectory(expand("~/.vim/undo"))
    silent call system("mkdir ~/.vim/undo")
  end
  set undodir=~/.vim/undo
endif

"========================================================================
"Plugins

"Check if Vundle needs to be installed
let vundleStat=1
if has("win32") || has("win64")
  if !isdirectory(expand($HOME."\\vimfiles\\bundle\\vundle"))
    silent call system("git clone https://github.com/gmarik/vundle ".$HOME."\\vimfiles\\bundle\\vundle")
    let vundleStat=0
  endif
  set rtp+=$HOME/vimfiles/bundle/vundle/
  silent call vundle#begin("$HOME/vimfiles/bundle/")
else
  if !isdirectory(expand("~/.vim/bundle/vundle"))
    silent call system("git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle")
    let vundleStat=0
  endif
  set rtp+=$HOME/.vim/bundle/vundle/
  call vundle#begin("$HOME/.vim/bundle/")
end

"AddPlugin allows for easy switching between plugin managers
"HasPlugin only loads plugin settings if the plugin was actually loaded
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
AddPlugin 'gmarik/vundle'

"Status line
AddPlugin 'bling/vim-airline'

"Unite, a powerful set of tools
AddPlugin 'Shougo/unite.vim'
if HasPlugin("unite.vim")
  AddPlugin 'ujihisa/unite-colorscheme'
  AddPlugin 'Shougo/vimfiler.vim'
endif

"File explorer sidebar
"AddPlugin 'scrooloose/nerdtree'

"CtrlP, another nice set of tools
AddPlugin 'ctrlpvim/ctrlp.vim'
if HasPlugin("ctrlp.vim")
  "Search by function name in file
  AddPlugin 'tacahiroy/ctrlp-funky'
endif

"Another way to browse by function name, requires ctags
AddPlugin 'majutsushi/tagbar'

"Code completion with <TAB>
AddPlugin 'ervandew/supertab'

"Surround, makes {a,b,c} -> [a,b,c] easy
AddPlugin 'tpope/vim-surround'

"Buffer handling
"AddPlugin 'mattdbridges/bufkill.vim'

"Switch buffers in the split layout
AddPlugin 'wesQ3/vim-windowswap'

"Giant collection of colorschemes
AddPlugin 'flazz/vim-colorschemes'
AddPlugin 'whatyouhide/vim-gotham'
AddPlugin 'tomasr/molokai'
AddPlugin 'chriskempson/base16-vim'
AddPlugin 'altercation/vim-colors-solarized'
AddPlugin 'Lokaltog/vim-distinguished'
AddPlugin 'vim-scripts/xoria256.vim'
"AddPlugin 'nanotech/jellybeans.vim'
"AddPlugin 'ChrisKempson/Vim-Tomorrow-Theme'

"Colorscheme chooser
"AddPlugin 'xolox/vim-misc'
"AddPlugin 'xolox/vim-colorscheme-switcher'

"Start page
AddPlugin 'mhinz/vim-startify'

"Improved syntax highlighting
AddPlugin 'sheerun/vim-polyglot'
"AddPlugin 'd3vas3m/Improved-Syntax-Highlighting-Vim'
"AddPlugin 'hdima/python-syntax'

"Show trailing whitespace
AddPlugin 'ntpeters/vim-better-whitespace'

"Indentation marking
AddPlugin 'nathanaelkane/vim-indent-guides'

if v:version >= 703
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
"Pane height (apples to horizontal drawers, such as unite and ctrlp)
let paneHeight = 12

"Tagbar
if HasPlugin('tagbar')
  let g:tagbar_left = 1
  let g:tagbar_vertical = paneHeight
  let g:tagbar_autoclose = 1
  let g:tagbar_autofocus = 1
  nnoremap <F8> :TagbarToggle<CR>
endif

"Startify
if HasPlugin('vim-startify')
  let g:startify_skiplist = [
      \ 'COMMIT_EDITMSG',
      \ $VIMRUNTIME .'/doc',
      \ 'bundle/.*/doc',
      \ ]
  autocmd FileType startify setlocal colorcolumn=
  nnoremap <leader>s :Startify<CR>
endif

"Airline
if HasPlugin('vim-airline')
  set ttimeoutlen=50
  "Don't show whitespace, there's another plugin for that
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
  "autocmd vimenter * if !argc() | NERDTree | endif
  "if just NERDTree left, quit
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
  let g:NERDTreeWinSize=paneWidth
  map <C-n> :NERDTreeToggle<CR>
  nnoremap <leader>n :NERDTreeToggle<CR>
endif

"CtrlP
if HasPlugin('ctrlp.vim')
  let g:ctrlp_funky_syntax_highlight = 1
  let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn)$',
      \ 'file': '\v\.(exe|so|dll)$',
      \ 'link': 'some_bad_symbolic_links',
      \ }
  let g:ctrlp_open_multiple_files = 'ri'
  let g:ctrlp_match_window = 'top,max:' . paneHeight
  nnoremap <C-P> :CtrlP<CR>
  nnoremap <C-B> :CtrlPBuffer<CR>
  if HasPlugin('ctrlp-funky')
    let g:ctrlp_extensions = ['funky']
    nnoremap <C-F> :CtrlPFunky<CR>
  endif
endif

"Unite
if HasPlugin('unite.vim')
  call unite#custom#profile('default', 'context', {
  \   'start-insert' : 1,
  \   'winheight' : paneHeight,
  \ })
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
  "call unite#filters#sorter_default#use(['sorter_rank'])
  nnoremap <leader>uf :Unite file -start-insert<CR>
  nnoremap <leader>ub :Unite buffer -start-insert<CR>
  if HasPlugin('unite-colorscheme')
    nnoremap <leader>uc :Unite colorscheme -start-insert<CR>
  endif
  if HasPlugin('vimfiler.vim')
    let g:vimfiler_as_default_explorer = 1
  endif
endif

"Indentation Rules
if HasPlugin('vim-indent-guides')
  let g:indent_guides_start_level = 1
  let g:indent_guides_guide_size = 1
endif

"Whitespace
if HasPlugin('vim-better-whitespace')
  let g:better_whitespace_filetypes_blacklist=['unite']
  nnoremap <leader><SPACE> :ToggleWhitespace<CR>
endif

"Easymotion
if HasPlugin('vim-easymotion')
  " Disabled default mappings
  let g:EasyMotion_do_mapping = 0
  let g:EasyMotion_keys = 'asdfjkl;ghewiovn'
  " Set easymotion movement
  nmap s <Plug>(easymotion-bd-w)
endif

"UndoTree
if HasPlugin('undotree')
  nnoremap <leader>u :UndotreeToggle<CR>:AirlineRefresh<CR>
  nnoremap <F5> :UndotreeToggle<CR>:AirlineRefresh<CR>
  let g:undotree_SplitWidth = paneWidth
  let g:undotree_SetFocusWhenToggle = 1
"Gundo
elseif HasPlugin('gundo.vim')
  nnoremap <leader>u :GundoToggle<CR>
  nnoremap <F5> :GundoToggle<CR>
  let g:gundo_width = paneWidth
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
  nnoremap <leader>cq :ConqueTermVSplit<SPACE>
endif

"========================================================================
"Other commands and shortcuts

"Refresh syntax from the start
autocmd BufEnter * syntax sync fromstart
function! SyntaxRefresh()
  syntax on
  syntax sync fromstart
  AirlineRefresh
endfunction
command! Refresh call SyntaxRefresh()
nnoremap <leader>r :Refresh<CR>

"Buffers
nnoremap <leader>t :enew!<CR>
nnoremap <leader>k :bnext!<CR>
nnoremap <leader>j :bprevious!<CR>
nnoremap <leader>x :bp <BAR> bd #<CR>

"Split navigation
nnoremap <leader>v :vsplit<CR><C-W><C-L>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Common shortcuts
inoremap jj <ESC>
nnoremap <leader>w :w<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>aq :qa<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>e :e<SPACE>

"Change directory to current file's
nnoremap <leader>cd :cd %:p:h<CR>

"Reload vimrc
nnoremap <leader>rc :so $MYVIMRC<CR>

"Clear the search
nnoremap <leader>/ :nohl <BAR> let @/=""<CR>

"Paste toggle
set pastetoggle=<F10>
nnoremap <leader>p :set invpaste<CR>

"========================================================================
"Syntax, fonts, themes, and colorscheme
syntax on
set t_Co=256
set background=dark
let g:airline_theme='tomorrow'
colorscheme Tomorrow-Night

"GUI Options
if has('gui_running')
  if has('win32') || has('win64')
    set guifont=DejaVu_Sans_Mono:h10
  else
    set guifont=DejaVu\ Sans\ Mono\ 10
  endif

"Conemu
elseif !empty($CONEMUBUILD)
  set term=xterm
  let &t_AB="\e[48;5;%dm"
  let &t_AF="\e[38;5;%dm"
  "weird behaviour with Conemu
  set t_Co=256
  let g:airline_theme='tomorrow'
  colorscheme Tomorrow-Night

"Windows commandline
elseif has('win32') || has('win64')
  let g:airline_theme='murmur'
  colorscheme default

"Probably Unix commandline
else
  "This prevents a huge lag in start time
  set clipboard=exclude:.*
endif
