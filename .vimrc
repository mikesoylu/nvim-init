set rtp+=~/.vim/bundle/vundle/
set rtp+=~/.fzf

call vundle#rc()

" let Vundle manage Vundle
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
set noswapfile

set ignorecase
set smartcase

set tabstop=2
set shiftwidth=2
set expandtab

set wildignorecase

" Custom mappings
"""""""""""""""""
" Map leader to space
let mapleader=" "

" Terminal mode
au TermOpen *bin/fish* tnoremap <buffer> <esc> <C-\><C-n>
au TermOpen * setlocal statusline=\ 

" File-relative commands
cabbr <expr> %% expand('%:p:h')

" Fix those pesky situations where you edit & need sudo to save
cmap w!! w !sudo tee % >/dev/null

" Plugin configurations
"""""""""""""""""""""""
" Auto open grep in quickfix
au QuickFixCmdPost *grep* cwindow

" Delete hidden fugitive buffers
au BufReadPost fugitive://* set bufhidden=delete

" FZF
let g:fzf_layout = { 'down': '~20%' }

nnoremap <leader>f :GitFiles<cr>
nnoremap <leader>l :GitLines<cr>
nnoremap <leader>g :GitGrepLines<cr>
nnoremap <leader>b :Buffers<cr>

function! s:escape(path)
  return substitute(a:path, ' ', '\\ ', 'g')
endfunction

function! GitLineHandler(line)
  let parts = split(a:line, ':')
  let [fn, lno] = parts[0 : 1]
  execute 'e '. s:escape(fn)
  execute lno
  normal! zz
endfunction

command! GitLines call fzf#run({
  \ 'source': 'git grep -n -I --untracked -i .',
  \ 'sink': function('GitLineHandler'),
  \ 'down': '40%'
\ })

command! GitGrepLines call fzf#run({
  \ 'source': 'git grep -n -I --untracked -i "'.expand("<cword>").'"',
  \ 'sink': function('GitLineHandler'),
  \ 'down': '20%'
\ })

" markdown
let g:vim_markdown_folding_disabled=1

" Custom commands
"""""""""""""""""

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
  let expansionString = repeat(".", w - strwidth(foldSizeStr.line.foldLevelStr))
  return line . expansionString . foldSizeStr . foldLevelStr
endf

set foldtext=CustomFoldText()
