set rtp+=~/.vim/bundle/vundle/
set rtp+=~/.fzf

call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" System
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-sleuth'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-rsi'
Bundle 'bronson/vim-trailing-whitespace'
Bundle 'tComment'
Bundle 'jmcantrell/vim-virtualenv'
Bundle 'mattn/emmet-vim'
Bundle 'vim-scripts/matchit.zip'
Bundle 'simnalamburt/vim-mundo'

" Syntaxes and such.
Bundle 'leafgarland/typescript-vim.git'
Bundle 'leshill/vim-json'
Bundle 'kchmck/vim-coffee-script'
Bundle 'plasticboy/vim-markdown'
Bundle 'groenewege/vim-less'
Bundle 'digitaltoad/vim-jade'
Bundle 'wavded/vim-stylus'
Bundle 'mxw/vim-jsx'
Bundle 'rhysd/conflict-marker.vim'

" Colorscheme
Bundle 'NLKNguyen/papercolor-theme'

" Basic
syntax on
filetype plugin indent on

" Colorscheme
colorscheme PaperColor
set background=light

set showcmd
set encoding=utf-8
set nocompatible
set grepprg=grep
set laststatus=2
set statusline=\ %m%t\ %r%y%q\ b%n:%{join(filter(range(1,bufnr('$')),'buflisted(v:val)'),',')}%=@%{fugitive#head(8)}\ %c\ (%P)\ 
set number
set hidden
set clipboard=unnamed
set backspace=indent,eol,start
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
set tabstop=2
set expandtab
set shiftround
set smarttab
set autoindent
set copyindent
set foldlevel=99
set foldignore=
set lazyredraw
set list
set listchars=tab:▸\ ,trail:•
set mouse=a
set nobackup
set noswapfile
set noshowmode
set undofile
set undodir=~/.vim_history

" File Navigation
""""""""""""""""""""""""""""""""
set path=**
set wildmode=full
set wildmenu
set suffixesadd=.coffee,.js,.rb,.java,.html
set wildignore=*/bin/*,*/node_modules/*,*/dist/*,*/bower_components/*

" I CAN HAZ NORMAL REGEXES?
"""""""""""""""""""""""""""
nnoremap / /\v
vnoremap / /\v

" General auto-commands
"""""""""""""""""""""""
" show column 80 marker
au FileType * setlocal colorcolumn=80

" Delete unused buffers
" au BufEnter * setlocal bufhidden=delete

au QuickFixCmdPost *grep* cwindow

" Restore cursor position
au BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" Allow manual folds
augroup vimrc
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

" Custom mappings
""""""""""""""""""
" enforce purity
noremap  <Up> <Nop>
noremap  <Down> <Nop>
noremap  <Left> <Nop>
noremap  <Right> <Nop>

" File-relative commands
cabbr <expr> %% expand('%:p:h')

" Change leader
let mapleader = ","
let g:mapleader = ","

" General search
nnoremap <Leader>gg :Ggrep -i <cword><CR>
nnoremap <leader>g :Ggrep -i ''<Left>

" Get rid of search hilighting with ,/
nnoremap <silent> <leader>/ :nohlsearch<CR>

" Exptand tabs
nnoremap <silent> <leader>rt :set\ et|retab<CR>

" Fix those pesky situations where you edit & need sudo to save
cmap w!! w !sudo tee % >/dev/null

" Plugin configurations
"""""""""""""""""""""""

" Delete hidden fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

" FZF
nnoremap <silent> <leader>t :FZF<CR>
nnoremap <silent> <leader>f :FZFLines<CR>

" gundo
nnoremap <silent> <leader>u :GundoToggle<CR>

" markdown
let g:vim_markdown_folding_disabled=1

" EmmetVim
imap ,hh <C-y>,
nmap <Leader>hh <C-y>,
vmap <Leader>hh <C-y>,

" FZF line search
function! s:line_handler(l)
  let keys = split(a:l, ':\t')
  exec 'buf' keys[0]
  exec keys[1]
  normal! ^zz
endfunction

function! s:buffer_lines()
  let res = []
  for b in filter(range(1, bufnr('$')), 'buflisted(v:val)')
    if (matchstr(bufname(b), "^term:") != "term:")
      call extend(res, map(getbufline(b,0,"$"), 'b . ":\t" . (v:key + 1) . ":\t" . v:val '))
    endif
  endfor
  return res
endfunction

command! FZFLines call fzf#run({
\   'source':  <sid>buffer_lines(),
\   'sink':    function('<sid>line_handler'),
\   'options': '--extended --nth=3..',
\   'down':    '60%'
\})

" Other customizations
""""""""""""""""""""""

" Colorize statusline in insert and visual modes
function! SetStatusLineColorInsert(mode)
  " Insert mode: white
  if a:mode == "i"
    hi StatusLine cterm=bold ctermfg=236 ctermbg=white

  " Replace mode: red
  elseif a:mode == "r"
    hi StatusLine cterm=bold ctermfg=white ctermbg=161

  endif
endfunction

function! SetStatusLineColorVisual()
  set updatetime=0

  " Visual mode: orange
  hi StatusLine cterm=bold ctermfg=white ctermbg=166

  " don't goto char when entering visual mode
  return ''
endfunction

function! ResetStatusLineColor()
  set updatetime=4000

  " Normal mode: blue
  hi StatusLine cterm=bold ctermfg=white ctermbg=24
endfunction

vnoremap <silent> <expr> <SID>SetStatusLineColorVisual SetStatusLineColorVisual()
nnoremap <silent> <script> v v<SID>SetStatusLineColorVisual
nnoremap <silent> <script> V V<SID>SetStatusLineColorVisual
nnoremap <silent> <script> <C-v> <C-v><SID>SetStatusLineColorVisual

augroup StatusLineColorSwap
    autocmd!
    autocmd InsertEnter * call SetStatusLineColorInsert(v:insertmode)
    autocmd InsertLeave * call ResetStatusLineColor()
    autocmd CursorHold * call ResetStatusLineColor()
augroup END

" Delete all hidden buffers
fu! DeleteHiddenBuffers()
  let tpbl=[]
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    if (matchstr(bufname(buf), "^term:") != "term:")
      silent execute 'bwipeout' buf
    endif
  endfor
endf

command! DeleteBuffers call DeleteHiddenBuffers()

" Better fold text
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
  let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
  let expansionString = repeat(".", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
  return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endf
set foldtext=CustomFoldText()

" NeoVim Configs
if has('nvim')
  " Escape terminal mode
  tnoremap <Esc> <C-\><C-n>

  " Statusline reset
  function! ResetTerminalStatusLineColor()
    if mode() ==# "t"
      " Terminal mode: white
      hi StatusLine cterm=bold ctermfg=236 ctermbg=white

    elseif mode() ==# "n"
      " Normal mode: blue
      hi StatusLine cterm=bold ctermfg=white ctermbg=24
    endif

    return ""
  endfunction

  let &stl.='%{ResetTerminalStatusLineColor()}'

  " Open terminal in login shell
  command! T execute "e term://zsh\\ -l"
endif
