call plug#begin('~/.vim/plugged')

" Plugins
"""""""""

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Kill buffers without closing pane
Plug 'qpkorr/vim-bufkill'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Smooth scrolling
Plug 'psliwka/vim-smoothie'

" AI
Plug 'github/copilot.vim'

" Line wrapping
Plug 'reedes/vim-pencil'

" Intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" File browser
Plug 'preservim/nerdtree'

" History browser
Plug 'mbbill/undotree'

" Colorscheme
Plug 'sonph/onehalf', { 'rtp': 'vim' }

" Better Quickfix behaviour
Plug 'yssl/QFEnter'

" Plugins End
call plug#end()

" Basic config
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
set listchars=tab:›\ ,nbsp:+
set smarttab
set tabpagemax=50
set viminfo+=!
set wildmenu
set undofile
set undodir=~/.vim_undo
set colorcolumn=80
set nowrapscan
set guioptions=
set exrc
set gdefault
set mouse=a
set number relativenumber

colorscheme onehalflight
set background=light

" GUI
if has('gui_running')
  set guifont=Menlo:h13
endif

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Statusline
""""""""""""
function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' ') . ' '
endfunction

let &statusline = ''
let &statusline .= '%1*%{StatusDiagnostic()}'
let &statusline .= '%0* %l'
let &statusline .= '%0*:%c'
let &statusline .= '%0* %<%f'
let &statusline .= '%#Error#%m%r%w'
let &statusline .= '%0*  %=%{FugitiveHead()} '

" Vim8.1 settings
if exists('+termwinkey')
  " set terminal key
  set termwinkey=<C-B>

  " remap escape terminal
  tnoremap <C-[> <C-B>N
  tnoremap <D-[> <Esc>

  " let me paste
  tnoremap <D-v> <C-B>"0

  " leave space on left
  set signcolumn=number
endif

" Neovim settings
"""""""""""""""""
if has('nvim')
  " term statusline aesthetics
  au TermOpen * setlocal statusline=terminal nonumber norelativenumber nospell

  " remap escape in terminal (but not fzf)
  au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  au FileType fzf tunmap <buffer> <Esc>
  tnoremap <D-[> <Esc>

  " incremental substitutions
  set inccommand=nosplit

  " leave space on left
  set signcolumn=yes
endif

" Custom mappings
"""""""""""""""""

function! Alias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

" Map leader to space
let mapleader=" "

" Special paste
vnoremap <Leader>p "0p
nnoremap <Leader>p "0p

" Visually search by yanking selected text
vnoremap * y/<C-R>"<CR>
vnoremap # y?<C-R>"<CR>

" Terminal split
command! -nargs=* TSplit belowright split | resize 20 | terminal <args>
call Alias("ts","TSplit")

" Args list
nmap <silent> gi :next<CR>
nmap <silent> go :previous<CR>

call Alias("aa","argadd")
call Alias("ad","argdelete")

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

" Replace word under cursor
nnoremap <Leader>r :%s/\<<C-r><C-w>\>/

" Abbreviate copen
call Alias("cop","copen")

" Close buffers
call Alias("bdall","bufdo bd")

" Plugin configurations
"""""""""""""""""""""""

" History browser
nnoremap <Leader>u :UndotreeToggle<CR>

" Quickfix window
autocmd FileType qf wincmd J
autocmd FileType qf setlocal nonumber norelativenumber nospell
let g:qfenter_keymap = {}
let g:qfenter_keymap.vopen = ['<c-v>']
let g:qfenter_keymap.hopen = ['<c-x>']

" Smooth Scroll
let g:smoothie_speed_constant_factor = 20
let g:smoothie_speed_linear_factor = 20

" NERD tree

call Alias("nf","NERDTreeFind")
call Alias("nerd","NERDTree")

let NERDTreeShowHidden = 1
let NERDTreeIgnore = ['\.DS_Store$']
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMapOpenSplit = '<c-x>'
let NERDTreeMapPreviewVSplit = '<c-v>'

" Use bufkill
call Alias("bd","BD")

" Delete hidden fugitive buffers
au BufReadPost fugitive://* set bufhidden=delete

" Pencil
let g:pencil#wrapModeDefault = 'soft'

augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init()
augroup END

" FZF mappings
nnoremap <leader>j :BLines<cr>
nnoremap <leader>J :Lines<cr>
nnoremap <leader>f :Files<cr>
nnoremap <leader>g :Buffers<cr>
nnoremap <leader>a :Args<cr>
nnoremap <leader>l :Rg<cr>
nnoremap <leader>s yiw:Rg <C-R>"<cr>
vnoremap <leader>s y:Rg <C-R>"<cr>

let g:fzf_layout = { 'window': { 'width': 1, 'height': 1 } }
let g:fzf_preview_window = ['down:40%', 'ctrl-/']

command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --smart-case -- ".shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

command! -bang Args call fzf#run(fzf#vim#with_preview(fzf#wrap('args',
    \ {'source': map([argidx()]+(argidx()==0?[]:range(argc())[0:argidx()-1])+range(argc())[argidx()+1:], 'argv(v:val)')}, <bang>0)))


" Netrw Settings
let g:netrw_banner = 0
let g:netrw_liststyle = 3

" COC settings

" Popup colors
highlight CocMenuSel ctermbg=LightGray ctermfg=Black guibg=LightGray guifg=Black

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `g[` and `g]` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> g[ <Plug>(coc-diagnostic-prev)
nmap <silent> g] <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> ga <Plug>(coc-codeaction-cursor)

" Use R to rename instead of replace
nnoremap <silent> R :call <Plug>(coc-rename)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
