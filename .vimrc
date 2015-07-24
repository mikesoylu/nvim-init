set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" System
Bundle 'scrooloose/nerdtree'
Bundle 'majutsushi/tagbar'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-sleuth'
Bundle 'tpope/vim-endwise'
Bundle 'bronson/vim-trailing-whitespace'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'ZoomWin'
Bundle 'tComment'
Bundle 'jmcantrell/vim-virtualenv'
Bundle 'soramugi/auto-ctags.vim'

" Syntaxes and such.
Bundle 'leafgarland/typescript-vim.git'
Bundle 'leshill/vim-json'
Bundle 'kchmck/vim-coffee-script'
Bundle 'plasticboy/vim-markdown'
Bundle 'groenewege/vim-less'
Bundle 'othree/html5.vim'
Bundle 'digitaltoad/vim-jade'
Bundle 'wavded/vim-stylus'
Bundle 'tpope/vim-rails'
Bundle 'mattn/emmet-vim'
Bundle 'skammer/vim-css-color'
Bundle 'Lokaltog/vim-powerline'
Bundle 'lsdr/monokai'
Bundle 'nathanaelkane/vim-indent-guides'

" OS - ENV specific stuff
""""""""""""""""
if has("win32")
    set guifont=Consolas
else
    set guifont=Menlo:h12
endif

if !has("gui_running")
    colorscheme elflord
else
    set guioptions=-t
    colorscheme monokai
endif

if executable('zsh')
  set shell=zsh\ -l
endif

" Basic
syntax on
filetype plugin indent on     " required!

set background=dark
set encoding=utf-8
set nocompatible
set relativenumber
set cursorcolumn
set cursorline
set grepprg=grep
set laststatus=2
set number
set hidden
set clipboard=unnamed
set backspace=indent,eol,start
set directory=/tmp//
set backupskip=/tmp/*,/private/tmp/*
set ffs=unix,dos,mac
set nowrap
set showmatch
set ignorecase
set smartcase
set hlsearch
set incsearch
set history=1000
set undolevels=1000
set title
set novisualbell
set noerrorbells
set scrolloff=4
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set shiftround
set smarttab
set autoindent
set copyindent
set foldmethod=indent
set foldlevel=99
set complete=.,w,b,u,t,i,k

" Highlight VCS conflict markers
""""""""""""""""""""""""""""""""
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" I CAN HAZ NORMAL REGEXES?
"""""""""""""""""""""""""""
nnoremap / /\v
vnoremap / /\v

" NO SHIFT PLEASE
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" General auto-commands
"""""""""""""""""""""""
autocmd FileType * setlocal colorcolumn=80

autocmd BufEnter * setlocal bufhidden=delete

autocmd QuickFixCmdPost *grep* cwindow

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" Custom mappings
""""""""""""""""""
" enforce purity
noremap  <Up> <Nop>
noremap  <Down> <Nop>
noremap  <Left> <Nop>
noremap  <Right> <Nop>
inoremap <esc> <nop>

" File-relative commads
cabbr <expr> %% expand('%:p:h')

" Change leader
let mapleader = ","
let g:mapleader = ","

" Genral search
nnoremap <Leader>gg :Ggrep -i <cword><CR>
nnoremap <leader>g :Ggrep -i ''<Left>

" Restore cursor position
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Get rid of search hilighting with ,/
nnoremap <silent> <leader>/ :nohlsearch<CR>

" Fix those pesky situations where you edit & need sudo to save
cmap w!! w !sudo tee % >/dev/null

" quickfix close
nnoremap <silent> <C-c> :ccl<CR>

" Plugin configurations
"""""""""""""""""""""""

" markdown
let g:vim_markdown_folding_disabled=1

" NERDTree
nnoremap <Leader>ff :NERDTreeFind<CR>
nnoremap <Leader>f :NERDTree<CR>
nnoremap <Leader>fc :NERDTreeToggle<CR>

" EmmetVim
imap ,hh <C-y>,
nmap <Leader>hh <C-y>,
vmap <Leader>hh <C-y>,

" Double rainbow - What does it mean!?
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help']
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_color_change_percent = 5

" Ctags
let g:auto_ctags = 1
let g:auto_ctags_directory_list = ['.git', '.svn']
let g:auto_ctags_filetype_mode = 1
let g:auto_ctags_filetype_mode = 1
let g:auto_ctags_tags_name = '.tags'
