set rtp+=~/.vim/bundle/vundle/
set rtp+=~/.fzf

call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" System
Bundle 'tpope/vim-fugitive'

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
set background=light

" Basic config
syntax on
filetype plugin on

set statusline=\ %m%t\ %r%y%q%=@%{fugitive#head(8)}\ %c,%l\ (%P)\ 
set hidden
set clipboard=unnamed
set nowrap

set ignorecase
set smartcase

set tabstop=2
set shiftwidth=2
set expandtab

set foldignore=

set list

set path=.,,**
set suffixesadd=.rb,.java
set wildignore=*/bin/*,*/node_modules/*,*/dist/*,*/bower_components/*
set wildignorecase

" General auto-commands
"""""""""""""""""""""""

" show column 80 marker
au FileType * setlocal colorcolumn=80

au QuickFixCmdPost *grep* cwindow

" Custom mappings
""""""""""""""""""

" Escape terminal mode
tnoremap <Esc> <C-\><C-n>
tnoremap <D-v> <C-\><C-n>pi

" File-relative commands
cabbr <expr> %% expand('%:p:h')

" Open terminal in login shell
cabbr <expr> term "term://zsh\\ -l"

" Change leader
let mapleader = " "
let g:mapleader = " "

" General search
nnoremap <Leader>gg :Ggrep -i <cword><CR>
nnoremap <Leader>g :Ggrep -i ''<Left>

" Fix those pesky situations where you edit & need sudo to save
cmap w!! w !sudo tee % >/dev/null

" Plugin configurations
"""""""""""""""""""""""

" Delete hidden fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

" markdown
let g:vim_markdown_folding_disabled=1

" Custom commands
"""""""""""""""""""""""

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
