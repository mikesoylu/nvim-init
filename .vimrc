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
NeoBundle 'henrik/vim-qargs'
NeoBundle 'neomake/neomake'
NeoBundle 'mikesoylu/fzf.vim'
NeoBundle 'reedes/vim-pencil'
NeoBundle 'ahw/vim-hooks'

" End NeoBundle
call neobundle#end()

" Basic config
syntax off
filetype plugin on

set maxmempattern=10000
set spelllang=en
set hidden
set clipboard=unnamed
set nowrap
set foldignore=
set list
set ruler
set nobackup
set nowritebackup
set noswapfile
set splitright
set ignorecase
set smartcase
set tabstop=2
set shiftwidth=2
set expandtab
set foldmethod=manual
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
set re=1 " use old regex engine
set undofile
set undodir=~/.vim_undo
set colorcolumn=80

" Statusline
""""""""""""
let &statusline .= '%1*%{neomake#statusline#QflistStatus("C ")}'
let &statusline .= '%1*%{neomake#statusline#LoclistStatus("L ")}'
let &statusline .= '%0* %l'
let &statusline .= '%0*:%c'
let &statusline .= '%0* %<%F'
let &statusline .= '%#Error#%m%r%w'
let &statusline .= '%0* [%L]'
let &statusline .= '%0* %y'

" Neovim settings
"""""""""""""""""
if has('nvim')
  " term statusline aesthetics
  au TermOpen * setlocal statusline=terminal

  " incremental substitutions
  set inccommand=nosplit

  " insert mode cursor shape
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
endif

" Custom mappings
"""""""""""""""""
" Map leader to space
let mapleader=" "

" Visually search by yanking selected text
vnoremap * y/<C-R>"<CR>
vnoremap # y?<C-R>"<CR>

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
let g:neomake_place_signs = 0
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_html_enabled_makers = ['htmlhint']

" Use bufkill
cabbr <expr> bd 'BD'

" Delete hidden fugitive buffers
au BufReadPost fugitive://* set bufhidden=delete

" Pencil
let g:pencil#wrapModeDefault = 'soft'

augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init()
augroup END

" FZF
let g:fzf_layout = { 'window': 'top 12new' }

nnoremap <leader>j :BLines<cr>
nnoremap <leader>J :Lines<cr>
nnoremap <leader>f :GitFiles<cr>
nnoremap <leader>g :Buffers<cr>
nnoremap <leader>h :History<cr>
nnoremap <leader>m :Marks<cr>
nnoremap <leader>l :Ag<cr>
nnoremap <leader>s yiw:Ag <C-R>"<cr>
vnoremap <leader>s y:Ag <C-R>"<cr>

" Enable Syntax for diff files
""""""""""""""""""""""""""""""
augroup PatchHighlight
  autocmd!
  autocmd BufEnter  *.patch,*.diff  let b:syntax_was_on = exists("syntax_on")
  autocmd BufEnter  *.patch,*.diff  syntax enable
  autocmd BufLeave  *.patch,*.diff  if !getbufvar("%","syntax_was_on")
  autocmd BufLeave  *.patch,*.diff      syntax off
  autocmd BufLeave  *.patch,*.diff  endif
augroup END

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
