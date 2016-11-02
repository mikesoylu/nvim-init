set rtp+=~/.vim/bundle/neobundle.vim/
set rtp+=/usr/local/opt/fzf/

" Start NeoBundle
call neobundle#begin(expand('~/.vim/bundle/'))

" General Setup
"""""""""""""""
" NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" System
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'qpkorr/vim-bufkill'
NeoBundle 'neomake/neomake'
NeoBundle 'mikesoylu/fzf.vim'

" Syntaxes
NeoBundle 'leshill/vim-json'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'groenewege/vim-less'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'wavded/vim-stylus'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'posva/vim-vue'
NeoBundle 'rust-lang/rust.vim'

" Colorscheme
NeoBundle 'NLKNguyen/papercolor-theme'

" End NeoBundle
call neobundle#end()

colorscheme PaperColor

" Basic config
syntax on
filetype plugin indent on

set spelllang=en
set hidden
set clipboard=unnamed
set nowrap
set foldignore=
set list
set ruler
set textwidth=80
set number
set nobackup
set nowritebackup
set noswapfile
set splitright
set ignorecase
set smartcase
set tabstop=2
set shiftwidth=2
set expandtab
set foldmethod=syntax
set autoindent
set autoread
set backspace=indent,eol,start
set display=lastline
set hlsearch
set incsearch
set langnoremap
set laststatus=2
set listchars=tab:>\ ,trail:-,nbsp:+
set smarttab
set tabpagemax=50
set ttyfast
set viminfo+=!
set wildmenu

" Term settings
"""""""""""""""""
if has('nvim')
  " term statusline aesthetics
  au TermOpen * setlocal statusline=terminal
endif

" Custom mappings
"""""""""""""""""
" Map leader to space
let mapleader=" "

" Visually search by yanking selected text
vnoremap * y/<C-R>"<CR>
vnoremap # y?<C-R>"<CR>

" Clear highlight
nnoremap <silent> <esc> :noh<return><esc>

" File-relative commands
cabbr <expr> %% expand('%:p:h')

" Fix those pesky situations where you edit & need sudo to save
cmap w!! w !sudo tee % >/dev/null

" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler.
au BufReadPost *
  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" Plugin configurations
"""""""""""""""""""""""
" Neomake
au! BufWritePost,BufWinEnter * Neomake
let g:neomake_open_list = 2
let g:neomake_list_height = 2
let g:neomake_place_signs = 0

let g:neomake_javascript_enabled_makers = ['eslint', 'flow']
let g:neomake_html_enabled_makers = ['htmlhint']

" Use bufkill
cabbr <expr> bd 'BD'

" Delete hidden fugitive buffers
au BufReadPost fugitive://* set bufhidden=delete

" Let react files have js extensions
let g:jsx_ext_required = 0

" Markdown
let g:vim_markdown_folding_disabled=1

" FZF
nnoremap <leader>j :BLines<cr>
nnoremap <leader>J :Lines<cr>
nnoremap <leader>f :GitFiles<cr>
nnoremap <leader>g :Buffers<cr>
nnoremap <leader>h :History<cr>
nnoremap <leader>m :Marks<cr>
nnoremap <leader>l :Ag<cr>
nnoremap <leader>s yiw:Ag <C-R>"<cr>
vnoremap <leader>s y:Ag <C-R>"<cr>

" Sensible Fold Text
""""""""""""""""""""
fu! CustomFoldText()
  "get first non-blank line
  let fs = v:foldstart
  while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
  endwhile
  if fs > v:foldend
    let line = getline(v:foldstart)
  else
    let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
  endif

  let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
  let foldSize = 1 + v:foldend - v:foldstart
  let foldSizeStr = " " . foldSize . " lines "
  let foldLevelStr = repeat("+--", v:foldlevel)
  let lineCount = line("$")
  let expansionString = repeat(" ", w - strwidth(foldSizeStr.line.foldLevelStr))
  return line . expansionString . foldSizeStr . foldLevelStr
endf

set foldtext=CustomFoldText()
