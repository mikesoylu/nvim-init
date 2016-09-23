set rtp+=~/.vim/bundle/neobundle.vim/
set rtp+=~/.fzf

" Start NeoBundle
call neobundle#begin(expand('~/.vim/bundle/'))

" General Setup
"""""""""""""""
" NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" System
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'mikesoylu/fzf.vim'
NeoBundle 'qpkorr/vim-bufkill'
NeoBundle 'henrik/vim-qargs'
NeoBundle 'neomake/neomake'
NeoBundle 'justinmk/vim-sneak'

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

set spelllang=en,tr
set spellfile=~/.config/nvim/spell/words.add
set hidden
set clipboard=unnamed
set nowrap
set foldignore=
set list
set ruler
set textwidth=80
set number
set laststatus=1
set nobackup
set nowritebackup
set noswapfile
set splitright
set ignorecase
set smartcase
set tabstop=2
set shiftwidth=2
set expandtab
set grepprg=ag\ --nogroup\ --nocolor
set foldmethod=syntax

" Neovim settings
"""""""""""""""""
if has('nvim')
  " Only map esc in shell
  au TermOpen *bin/fish* tnoremap <buffer> <esc> <C-\><C-n>

  " term statusline aesthetics
  au TermOpen * setlocal statusline=term
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
vnoremap <silent> <esc> :noh<return><esc>

" File-relative commands
cabbr <expr> %% expand('%:p:h')

" Fix those pesky situations where you edit & need sudo to save
cmap w!! w !sudo tee % >/dev/null

" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler.
autocmd BufReadPost *
  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" Plugin configurations
"""""""""""""""""""""""
" JavaScript
let g:javascript_plugin_flow = 1

" Sneak around
let g:sneak#use_ic_scs = 1

xmap s <Plug>Sneak_s
xmap S <Plug>Sneak_S
omap s <Plug>Sneak_s
omap S <Plug>Sneak_S

hi link SneakStreakTarget ErrorMsg
hi link SneakStreakMask   WarningMsg
hi link SneakPluginTarget ErrorMsg
hi link SneakPluginScope  WarningMsg

" Neomake
autocmd! BufWritePost,BufWinEnter * Neomake

let g:neomake_warning_sign = {
  \ 'text': '✕',
  \ 'texthl': 'WarningMsg',
  \ }

let g:neomake_error_sign = {
  \ 'text': '✖︎',
  \ 'texthl': 'WarningMsg',
  \ }

" Use bufkill
cabbr <expr> bd 'BD'

" Delete hidden fugitive buffers
au BufReadPost fugitive://* set bufhidden=delete

" Let react files have js extensions
let g:jsx_ext_required = 0

" FZF madness
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

" Markdown
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
  let expansionString = repeat(" ", w - strwidth(foldSizeStr.line.foldLevelStr))
  return line . expansionString . foldSizeStr . foldLevelStr
endf

set foldtext=CustomFoldText()
