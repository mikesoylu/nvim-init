set encoding=utf-8
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" Vundle help
""""""""""""""
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles


" VCS
Bundle 'tpope/vim-fugitive'

" System
Bundle 'scrooloose/nerdtree'
Bundle 'vim-scripts/Gist.vim'
Bundle 'mileszs/ack.vim'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/syntastic'
Bundle 'ervandew/supertab'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'sophacles/vim-bundle-sparkup'
Bundle 'kien/ctrlp.vim'

" Syntaxes and such.
Bundle 'leafgarland/typescript-vim.git'
Bundle 'tpope/vim-cucumber'
Bundle 'leshill/vim-json'
Bundle 'tpope/vim-liquid'
Bundle 'puppetlabs/puppet-syntax-vim'
Bundle 'tpope/vim-haml'
Bundle 'kchmck/vim-coffee-script'
Bundle 'plasticboy/vim-markdown'
Bundle 'groenewege/vim-less'
Bundle 'jcf/vim-latex'
Bundle 'othree/html5.vim'
Bundle 'mutewinter/nginx.vim'
Bundle 'msanders/cocoa.vim'
Bundle 'empanda/vim-varnish'
Bundle 'itspriddle/vim-jquery'
Bundle 'atourino/jinja.vim'

" Python bundles
Bundle 'nvie/vim-flake8'
Bundle 'fs111/pydoc.vim'
Bundle 'vim-scripts/python_match.vim'
Bundle 'jmcantrell/vim-virtualenv'

" Fun, but not useful
Bundle 'davidoc/taskpaper.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'skammer/vim-css-color'
Bundle 'mgutz/vim-colors'
Bundle 'ehamberg/vim-cute-python'
Bundle 'tpope/vim-speeddating'
Bundle 'Lokaltog/vim-powerline'
Bundle 'chriskempson/base16-vim'
Bundle 'chreekat/vim-paren-crosshairs'

filetype plugin indent on     " required!

" Configurations
""""""""""""""""
set background=dark

" OS specific stuff
""""""""""""""""
if has("win32")
    set guifont=Consolas
endif

" AS3 syntax
autocmd BufRead *.as set filetype=Javascript
autocmd BufRead *.mxml set filetype=Javascript

" Wildmenu completion
"""""""""""""""""""""
set wildmenu
set wildmode=list:longest
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.luac                           " Lua byte code
set wildignore+=*.pyc                            " Python byte code
set wildignore+=**.class                          " Cursed Java class files

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

if !has("gui_running")
    colorscheme chance-of-storm
else
    colorscheme base16-monokai
endif

" Basic
syntax enable
set number        " always show line numbers
set hidden        " Allow un-saved buffers in background
set clipboard=unnamed " Share system clipboard.
set backspace=indent,eol,start " Make backspace behave normally.
set directory=/tmp// " swap files
set backupskip=/tmp/*,/private/tmp/*
set ffs=unix,dos,mac "Default file types
set nowrap        " don't wrap lines
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "  case-sensitive otherwise
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set title                " change the terminal's title
set novisualbell           " don't beep
set noerrorbells         " don't beep

" Remove the toolbar if we're running under a GUI (e.g. MacVIM).
if has("gui_running")
  set guioptions=-t
endif

" Special characters for hilighting non-priting spaces/tabs/etc.
"set list listchars=tab:»\ ,trail:·

" Default Tabs & spaces
set tabstop=4     " a tab is four spaces
set shiftwidth=4  " number of spaces to use for autoindenting
set softtabstop=4
set expandtab
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting

" General Code Folding
""""""""""""""""""""""
set foldmethod=indent
set foldlevel=99

" Highlight VCS conflict markers
""""""""""""""""""""""""""""""""
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" I CAN HAZ NORMAL REGEXES?
"""""""""""""""""""""""""""
nnoremap / /\v
vnoremap / /\v


" General auto-commands
"""""""""""""""""""""""
autocmd FileType * setlocal colorcolumn=0
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

" Get rid of trailing whitespace highlighting in mutt.
autocmd FileType mail highlight clear ExtraWhitespace
autocmd FileType mail setlocal listchars=

" Crontab auto-commands
"""""""""""""""""""""""
autocmd FileType crontab setlocal backupcopy=yes

" turn-on distraction free writing mode for markdown files
" au BufNewFile,BufRead *.{md,mdown,mkd,mkdn,markdown,mdwn} call DistractionFreeWriting()

function! DistractionFreeWriting()
    colorscheme iawriter
    set background=light
    set gfn=Cousine:h14                " font to use
    set lines=60 columns=100           " size of the editable area
    set fuoptions=background:#00f5f6f6 " macvim specific setting for editor's background color
    set guioptions-=r                  " remove right scrollbar
    set laststatus=0                   " don't show status line
    set noruler                        " don't show ruler
    set fullscreen                     " go to fullscreen editing mode
    set linebreak                      " break the lines on words
endfunction

:map <F8> :call DistractionFreeWriting()<CR>

" Toggle spellcheck in normal mode
:map <F5> :setlocal spell! spelllang=en_us<CR>

" HTML configurations
"""""""""""""""""""""
autocmd FileType html setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab

" Python configurations
"""""""""""""""""""""""
autocmd FileType python setlocal shiftwidth=4 expandtab tabstop=4 softtabstop=4
autocmd FileType python setlocal colorcolumn=80
autocmd FileType python map <buffer> <F4> :call Flake8()<CR>
autocmd FileType python autocmd BufWritePre * :%s/\s\+$//e
autocmd FileType python set omnifunc=pythoncomplete#Complete

" Coffeescript configurations
"""""""""""""""""""""""""""""
au BufNewFile,BufReadPost *.coffee setlocal foldmethod=indent
au BufNewFile,BufReadPost *.coffee setlocal shiftwidth=2 expandtab

" Javascript configurations
"""""""""""""""""""""""""""
au BufNewFile,BufReadPost *.js setlocal shiftwidth=2 expandtab

" Make sure we hilight extra whitespace in the most annoying way possible.
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" Custom mappings
""""""""""""""""""

" Change leader
let mapleader = ","
let g:mapleader = ","

" Genral
noremap <silent> <F4> :QFix<CR>

" Get rid of search hilighting with ,/
nnoremap <silent> <leader>/ :nohlsearch<CR>

" Fix those pesky situations where you edit & need sudo to save
cmap w!! w !sudo tee % >/dev/null


" Plugin configurations
"""""""""""""""""""""""

" Gist
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 2
let g:gist_show_privates = 1

" TaskList
map <leader>l <Plug>TaskList

" crtl-p
let g:ctrlp_map = '<c-p>'
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files --exclude-standard -co']

" NERDTree
nnoremap <Leader>f :NERDTreeToggle<CR>

" SnipMate
let g:snippets_dir = "~/.vim/bundle/snipmate-snippets"

" Sparkup
let g:sparkupExecuteMapping = '<c-y>'
let g:sparkupNextMapping = '<c-k>'

" Jedi
let g:jedi#goto_command = "<leader>g"

" Double rainbow - What does it mean!?
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

set laststatus=2
let g:syntastic_enable_signs = 1
let g:syntastic_auto_jump = 0

" Show a line at column 80
:set textwidth=80
:set colorcolumn=+1
