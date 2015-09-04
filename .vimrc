set rtp+=~/.fzf
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
Bundle 'tComment'
Bundle 'jmcantrell/vim-virtualenv'
Bundle 'Lokaltog/vim-powerline'
Bundle 'mattn/emmet-vim'
Bundle 'vim-scripts/matchit.zip'
Bundle 'christoomey/vim-tmux-navigator'

" Syntaxes and such.
Bundle 'leafgarland/typescript-vim.git'
Bundle 'leshill/vim-json'
Bundle 'kchmck/vim-coffee-script'
Bundle 'plasticboy/vim-markdown'
Bundle 'groenewege/vim-less'
Bundle 'digitaltoad/vim-jade'
Bundle 'wavded/vim-stylus'
Bundle 'tomasr/molokai'
Bundle 'mxw/vim-jsx'

" Basic
syntax on
filetype plugin indent on

colorscheme molokai

set background=dark
set encoding=utf-8
set nocompatible
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
set scroll=10
set expandtab
set shiftround
set smarttab
set autoindent
set copyindent
set foldmethod=manual
set foldlevel=99
set foldcolumn=1
set sessionoptions+=folds
set complete=.,w,b,u,t,i,k
set lazyredraw
set ttyfast
set list
set listchars=tab:▸\ ,trail:•

" Highlight VCS conflict markers
""""""""""""""""""""""""""""""""
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" I CAN HAZ NORMAL REGEXES?
"""""""""""""""""""""""""""
nnoremap / /\v
vnoremap / /\v

" General auto-commands
"""""""""""""""""""""""
" show column 80 marker
au FileType * setlocal colorcolumn=80

" Delete unused buffers
au BufEnter * setlocal bufhidden=delete

au QuickFixCmdPost *grep* cwindow

" Restore folds
au BufWinLeave ?* mkview
au BufWinEnter ?* silent loadview

" Restore cursor position
au BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" Custom mappings
""""""""""""""""""
" enforce purity
noremap  <Up> <Nop>
noremap  <Down> <Nop>
noremap  <Left> <Nop>
noremap  <Right> <Nop>

" File-relative commads
cabbr <expr> %% expand('%:p:h')

" Change leader
let mapleader = ","
let g:mapleader = ","

" Genral search
nnoremap <Leader>gg :Ggrep -i <cword><CR>
nnoremap <leader>g :Ggrep -i ''<Left>

" Get rid of search hilighting with ,/
nnoremap <silent> <leader>/ :nohlsearch<CR>

" Fix those pesky situations where you edit & need sudo to save
cmap w!! w !sudo tee % >/dev/null

" quickfix close
nnoremap <silent> <C-c> :ccl<CR>

" Bang!
noremap Q !!$SHELL<CR>

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

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

" Fuzzy finder
nnoremap <Leader>t :FZF<CR>
