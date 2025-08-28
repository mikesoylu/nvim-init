-- =========================
--  Basic config (options)
-- =========================

vim.g.mapleader = " "
vim.opt.maxmempattern = 10000
vim.opt.spelllang = "en"
vim.opt.hidden = true
vim.opt.clipboard = "unnamed"
vim.opt.wrap = false
vim.opt.foldignore = ""
vim.opt.list = true
vim.opt.ruler = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.splitright = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.foldmethod = "manual"
vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.display = "lastline"
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.langnoremap = true
vim.opt.laststatus = 2
vim.opt.listchars = { tab = "› ", nbsp = "+" }
vim.opt.smarttab = true
vim.opt.tabpagemax = 50
vim.opt.viminfo:append("!")
vim.opt.wildmenu = true
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.vim_undo")
vim.opt.colorcolumn = "80"
vim.opt.wrapscan = false
vim.opt.exrc = true
vim.opt.gdefault = true
vim.opt.mouse = "a"
vim.opt.cursorline = true
vim.opt.background = "dark"
vim.opt.inccommand = "nosplit"
vim.opt.signcolumn = "yes"


-- =========================
--  Plugin Manager: lazy.nvim
-- =========================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git","clone","--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Git
  { "tpope/vim-fugitive" },
  { "tpope/vim-rhubarb" },

  -- Kill buffers without closing pane
  { "qpkorr/vim-bufkill" },

  -- Better f & t
  { "dahu/vim-fanfingtastic" },

  -- Fuzzy finder
  { "junegunn/fzf", build = function() vim.fn["fzf#install"]() end },
  { "junegunn/fzf.vim" },

  -- Smooth scrolling
  { "psliwka/vim-smoothie" },

  -- AI
  { "github/copilot.vim" },
  { "mikesoylu/ai.vim" },

  -- Line wrapping
  { "reedes/vim-pencil" },

  -- Intellisense
  { "neoclide/coc.nvim", branch = "release" },

  -- File browser
  { "preservim/nerdtree" },

  -- History browser
  { "mbbill/undotree" },

  -- Colorscheme
  { "navarasu/onedark.nvim" },

  -- Better Quickfix behaviour
  { "yssl/QFEnter" },

  -- Better syntax
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- opencode.nvim: AI-powered code assistant
  {
    'NickvanDyke/opencode.nvim',
    dependencies = { 'folke/snacks.nvim', },
    ---@type opencode.Config
    opts = {
      -- Your configuration, if any
    },
    -- stylua: ignore
    keys = {
      { '<leader>ot', function() require('opencode').toggle() end, desc = 'Toggle embedded opencode', },
      { '<leader>oa', function() require('opencode').ask() end, desc = 'Ask opencode', mode = 'n', },
      { '<leader>oa', function() require('opencode').ask('@selection: ') end, desc = 'Ask opencode about selection', mode = 'v', },
      { '<leader>op', function() require('opencode').select_prompt() end, desc = 'Select prompt', mode = { 'n', 'v', }, },
      { '<leader>on', function() require('opencode').command('session_new') end, desc = 'New session', },
      { '<leader>oy', function() require('opencode').command('messages_copy') end, desc = 'Copy last message', },
      { '<S-C-u>',    function() require('opencode').command('messages_half_page_up') end, desc = 'Scroll messages up', },
      { '<S-C-d>',    function() require('opencode').command('messages_half_page_down') end, desc = 'Scroll messages down', },
    },
  }
})

-- GUI / truecolor
if vim.fn.has("gui_running") == 1 then
  vim.opt.guifont = "Menlo:h13"
end
if vim.fn.exists("+termguicolors") == 1 then
  vim.opt.termguicolors = true
end

-- Keep filetype plugin on (equivalent to :filetype plugin on)
vim.cmd.filetype({ args = { "plugin", "on" } })

-- =========================
--  Colorscheme
-- =========================
vim.env.BAT_THEME = "default"
require("onedark").setup({
  style = "dark",
  ending_tildes = true,
})
require("onedark").load()

-- =========================
--  Statusline (Coc + Fugitive)
-- =========================
function _G.StatusDiagnostic()
  local info = vim.b.coc_diagnostic_info or {}
  if not info or (info.error == 0 and info.warning == 0) then return "" end
  local msgs = {}
  if (info.error or 0) > 0 then table.insert(msgs, "E" .. info.error) end
  if (info.warning or 0) > 0 then table.insert(msgs, "W" .. info.warning) end
  return table.concat(msgs, " ") .. " "
end

vim.o.statusline = ""
vim.o.statusline = vim.o.statusline .. "%1*%{v:lua.StatusDiagnostic()}"
vim.o.statusline = vim.o.statusline .. "%0* %l"
vim.o.statusline = vim.o.statusline .. "%0*:%c"
vim.o.statusline = vim.o.statusline .. "%0* %<%f"
vim.o.statusline = vim.o.statusline .. "%#Error#%m%r%w"
vim.o.statusline = vim.o.statusline .. "%0*  %=%{FugitiveHead()} "

-- =========================
--  CursorLine toggling
-- =========================
local cursorline = vim.api.nvim_create_augroup("CursorLine", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
  group = cursorline,
  callback = function() vim.opt_local.cursorline = true end,
})
vim.api.nvim_create_autocmd("WinLeave", {
  group = cursorline,
  callback = function() vim.opt_local.cursorline = false end,
})

-- =========================
--  Terminal settings
-- =========================

-- Terminal aesthetics & keymaps
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function(args)
    -- local terminal window: statusline and no numbers/spell
    vim.opt_local.statusline = "terminal"
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.spell = false
    -- remap <Esc> to normal-mode (except for fzf, handled below)
    vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { buffer = args.buf, silent = true })
    -- <D-[> to <Esc>
    vim.keymap.set("t", "<D-[>", [[<Esc>]], { buffer = args.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "fzf",
  callback = function()
    -- unmap <Esc> inside fzf terminal
    pcall(vim.keymap.del, "t", "<Esc>", { buffer = 0 })
  end,
})

-- =========================
--  Command "aliases" (exact-name user commands)
-- =========================

-- Command-line alias helper (exact-match like your Vimscript)
local function alias(from, to)
  vim.cmd(string.format(
    [[cnoreabbrev <expr> %s ((getcmdtype() is# ":" && getcmdline() is# "%s") ? ("%s") : ("%s"))]],
    from, from, to, from
  ))
end

-- TSplit: terminal split below with height 20
vim.api.nvim_create_user_command("TSplit", function(opts)
  vim.cmd("belowright split")
  vim.cmd("resize 20")
  vim.cmd("terminal " .. table.concat(opts.fargs, " "))
end, { nargs = "*" })

alias("ts", "TSplit")

alias("aa", "argadd")
alias("ad", "argdelete")

-- File-relative "%%" in cmdline (map in cmdline to expand('%:p:h'))
vim.keymap.set("c", "%%", function() return vim.fn.expand("%:p:h") end, { expr = true })

-- sudo write: w!!  (command-line mapping)
vim.keymap.set("c", "w!!", function()
  return "w !sudo tee % >/dev/null"
end, { expr = true })

-- bdall -> bufdo bd (no need for a real command)
alias("bdall", "bufdo bd")

-- Prefer bufkill’s :BD; keep a lowercase alias for convenience
alias("bd", "BD")

-- Quickfix open
alias("cop", "copen")

local function delete_hidden_buffers()
  local tpbl = {}
  local closed = 0
  for t = 1, vim.fn.tabpagenr("$") do
    local bufs = vim.fn.tabpagebuflist(t)
    for _, b in ipairs(bufs) do tpbl[b] = true end
  end
  for b = 1, vim.fn.bufnr("$") do
    if vim.fn.bufexists(b) == 1 and not tpbl[b] then
      if vim.fn.getbufvar(b, "&mod") == 0 then
        pcall(vim.cmd.bwipeout, b)
        closed = closed + 1
      end
    end
  end
  print("Closed " .. closed .. " hidden buffers")
end

alias("bdhidden", "lua delete_hidden_buffers()")

-- =========================
--  Keymaps
-- =========================
-- Special paste (visual mode)
vim.keymap.set("x", "<leader>p", [["_dP]], { silent = true })

-- Visual search by yanking selected text
vim.keymap.set("v", "*", [["zy/<C-R>z<CR>]], { silent = true })
vim.keymap.set("v", "#", [["zy?<C-R>z<CR>]], { silent = true })

-- Args list
vim.keymap.set("n", "gi", ":next<CR>", { silent = true })
vim.keymap.set("n", "go", ":previous<CR>", { silent = true })

-- Replace word under cursor (keeps trailing / for your interactive typing)
vim.keymap.set("n", "<Leader>r", [[:%s/\<<C-r><C-w>\>/]], {})

-- Undotree
vim.keymap.set("n", "<Leader>u", ":UndotreeToggle<CR>", { silent = true })

-- AI mappings
vim.g.ai_no_mappings = 1
vim.g.ai_context_before = 512
vim.g.ai_context_after = 512
vim.g.ai_model = "gpt-5"
vim.keymap.set("i", "<C-l>", "<Esc>:AI<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", "<Esc>:AI ", { silent = false })
vim.keymap.set("v", "<C-l>", ":AI ", { silent = false })

-- =========================
--  Autocommands
-- =========================
-- Quickfix window bottom & local opts
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.cmd("wincmd J")
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.spell = false
  end,
})

-- Jump to last cursor position when reopening files (except gitcommit)
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    if vim.bo.filetype == "gitcommit" then return end
    local mark = vim.api.nvim_buf_get_mark(0, [["]])
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, { mark[1], mark[2] })
    end
  end,
})

-- Delete fugitive buffers when hidden
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "fugitive://*",
  callback = function() vim.opt_local.bufhidden = "delete" end,
})

-- Pencil (markdown/text)
vim.g["pencil#wrapModeDefault"] = "soft"
local pencil_grp = vim.api.nvim_create_augroup("pencil", { clear = true })
vim.api.nvim_create_autocmd("FileType", { group = pencil_grp, pattern = { "markdown", "mkd", "text" }, callback = function()
  vim.fn["pencil#init"]()
end })

-- =========================
--  Plugin configs / globals
-- =========================
-- QFEnter
vim.g.qfenter_keymap = { vopen = { "<c-v>" }, hopen = { "<c-x>" } }

-- Smoothie
vim.g.smoothie_speed_constant_factor = 20
vim.g.smoothie_speed_linear_factor = 20

-- NERDTree
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeIgnore = { [[\.DS_Store$]] }
vim.g.NERDTreeAutoDeleteBuffer = 1
vim.g.NERDTreeMapOpenSplit = "<c-x>"
vim.g.NERDTreeMapPreviewVSplit = "<c-v>"

alias("nf", "NERDTreeFind")
alias("nerd", "NERDTree")

-- netrw
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

-- Python host
vim.g.python3_host_prog = "python"

-- FZF settings & commands
vim.g.fzf_layout = { window = { width = 1, height = 1 } }
vim.g.fzf_preview_window = { "down:40%", "ctrl-/" }

vim.keymap.set("n", "<leader>j", ":BLines<cr>", { silent = true })
vim.keymap.set("n", "<leader>J", ":Lines<cr>", { silent = true })
vim.keymap.set("n", "<leader>f", ":Files<cr>", { silent = true })
vim.keymap.set("n", "<leader>g", ":Buffers<cr>", { silent = true })
vim.keymap.set("n", "<leader>a", ":Args<cr>", { silent = true })
vim.keymap.set("n", "<leader>l", ":Rg<cr>", { silent = true })
vim.keymap.set("n", "<leader>s", 'yiw:Rg <C-R>"<cr>', { silent = false })
vim.keymap.set("v", "<leader>s", 'y:Rg <C-R>"<cr>', { silent = false })

-- :Rg using fzf.vim helpers
vim.api.nvim_create_user_command("Rg", function(opts)
  local q = table.concat(opts.fargs, " ")
  local src = "rg --column --line-number --no-heading --smart-case -- " .. vim.fn.shellescape(q)
  vim.fn["fzf#vim#grep"](src, 1, vim.fn["fzf#vim#with_preview"]({ options = "--delimiter : --nth 4.." }), opts.bang and 1 or 0)
end, { nargs = "*", bang = true })

-- :Args fzf view (skip current arg)
vim.api.nvim_create_user_command("Args", function(opts)
  local argc   = vim.fn.argc()
  local argidx = vim.fn.argidx()
  local list   = {}

  -- indices: 0 .. argc-1, excluding argidx
  for i = 0, argc - 1 do
    if i ~= argidx then table.insert(list, vim.fn.argv(i)) end
  end

  vim.fn["fzf#run"](vim.fn["fzf#vim#with_preview"](
    vim.fn["fzf#wrap"]("args", { source = list }),
    opts.bang and 1 or 0
  ))
end, { bang = true })

-- =========================
--  CoC settings & mappings
-- =========================
-- Popup colors (CocMenuSel)
-- cterm attrs are not meaningful in GUI; set GUI colors; keep name identical.
vim.api.nvim_set_hl(0, "CocMenuSel", { bg = "LightGray", fg = "Black" })

-- <CR> confirm completion or do on_enter
local function t(str) return vim.api.nvim_replace_termcodes(str, true, true, true) end
vim.keymap.set("i", "<CR>", function()
  if vim.fn["coc#pum#visible"]() == 1 then
    return vim.fn["coc#pum#confirm"]()
  else
    return t("<C-g>u<CR><c-r>=coc#on_enter()<CR>")
  end
end, { expr = true, silent = true })

-- <c-space> to trigger completion (Neovim)
vim.keymap.set("i", "<C-Space>", function() return vim.fn["coc#refresh"]() end, { expr = true, silent = true })

-- Diagnostics navigation
vim.keymap.set("n", "g[", "<Plug>(coc-diagnostic-prev)", { silent = true })
vim.keymap.set("n", "g]", "<Plug>(coc-diagnostic-next)", { silent = true })

-- GoTo code navigation & code actions
vim.keymap.set("n", "gd", "<Plug>(coc-definition)", { silent = true })
vim.keymap.set("n", "gr", "<Plug>(coc-references)", { silent = true })
vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", { silent = true })
vim.keymap.set("n", "ga", "<Plug>(coc-codeaction-cursor)", { silent = true })

-- Rename with R (instead of replace)
vim.keymap.set("n", "R", "<Plug>(coc-rename)", { silent = true })

-- K: show documentation
local function show_documentation()
  local ft = vim.bo.filetype
  if ft == "vim" or ft == "help" then
    vim.cmd("h " .. vim.fn.expand("<cword>"))
  elseif vim.fn["coc#rpc#ready"]() == 1 then
    vim.fn.CocActionAsync("doHover")
  else
    vim.cmd("!" .. vim.o.keywordprg .. " " .. vim.fn.expand("<cword>"))
  end
end
vim.keymap.set("n", "K", show_documentation, { silent = true })

vim.api.nvim_create_user_command("Prettier", function()
  vim.fn.CocAction("runCommand", "prettier.formatFile")
end, {})

-- =========================
--  Treesitter
-- =========================
require("nvim-treesitter.configs").setup({
  auto_install = true,
  highlight = { enable = true },
  additional_vim_regex_highlighting = false,
})
