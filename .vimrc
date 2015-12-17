set rtp+=~/.vim/bundle/vundle/
set rtp+=~/.fzf

call vundle#rc()

" General Setup
"""""""""""""""
" Vundle
Bundle 'gmarik/vundle'

" System
Bundle 'tpope/vim-fugitive'
Bundle 'junegunn/fzf.vim'

" Syntaxes
Bundle 'leshill/vim-json'
Bundle 'kchmck/vim-coffee-script'
Bundle 'plasticboy/vim-markdown'
Bundle 'groenewege/vim-less'
Bundle 'digitaltoad/vim-jade'
Bundle 'wavded/vim-stylus'
Bundle 'mxw/vim-jsx'

" Colorscheme
Bundle 'NLKNguyen/papercolor-theme'

colorscheme PaperColor

" Basic config
syntax on
filetype plugin indent on

set hidden
set clipboard=unnamed
set nowrap
set foldignore=
set list
set ruler
set cursorline

set nobackup
set nowritebackup
set noswapfile

set splitbelow
set splitright

set ignorecase
set smartcase

set tabstop=2
set shiftwidth=2
set expandtab


" Custom mappings
"""""""""""""""""
" Map leader to space
let mapleader=" "

" Visually search by yanking selected text
vnoremap * y/<C-R>"<CR>
vnoremap # y?<C-R>"<CR>

" Terminal mode adjustments
" TODO find a way to eliminate bin/fish
au TermOpen *bin/fish* tnoremap <buffer> <esc> <C-\><C-n>
au TermOpen * setlocal statusline=[term] nocursorline

" File-relative commands
cabbr <expr> %% expand('%:p:h')

" Fix those pesky situations where you edit & need sudo to save
cmap w!! w !sudo tee % >/dev/null

" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" Plugin configurations
"""""""""""""""""""""""
" Delete hidden fugitive buffers
au BufReadPost fugitive://* set bufhidden=delete

" FZF madness
let g:fzf_layout = { 'down': '~30%' }

nnoremap <leader>f :Files<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>o :History<cr>
nnoremap <leader>l :Ag .<cr>
nnoremap <leader>s yiw:Ag <C-R>"<cr>
vnoremap <leader>s y:Ag <C-R>"<cr>

" markdown
let g:vim_markdown_folding_disabled=1


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
  let expansionString = repeat(".", w - strwidth(foldSizeStr.line.foldLevelStr))
  return line . expansionString . foldSizeStr . foldLevelStr
endf

set foldtext=CustomFoldText()
