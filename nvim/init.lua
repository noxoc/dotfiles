--
-- ʕ •ᴥ•ʔ 
--  This config is in between haircuts. 
--

-- Automatically install lazy.nvim when it is not yet installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

-- general {{{
vim.g.mapleader = ' '
vim.g.maplocalleader = ','
vim.o.clipboard = 'unnamed'
vim.o.hidden = true -- makes it possible to leave a buffer if it has unsaved changes. `gd` etc fail horribly in those cases.
vim.o.completeopt = 'menu,menuone,noselect,longest,preview'
vim.o.foldmethod = "marker"
vim.o.formatoptions = 'qrn1j' -- format options when writing, joining lines or `gq` see  :he fo-table for meanings
vim.o.mouse = 'a' -- enable scrolling and selecting with mouse
vim.o.updatetime = 250
vim.o.splitbelow = true -- When on, splitting a window will put the new window below the current one
vim.o.shiftround = true -- When at 3 spaces and I hit >>, go to 4, not 5.
vim.o.shell = '/bin/zsh' -- set default shell for :shell
vim.o.path = vim.o.path .. ',**'
vim.o.wildignore = table.concat({
  '.DS_Store',
  '**/.git/*',
  '*.jpg,*.bmp,*.gif,*.png,*.jpeg', -- ignore binary images
  '**/coverage/*',
  '**/node_modules/*',
  '**/android/*',
  '**/.git/*',
  '**/tmp/*',
}, ',')

-- search settings
vim.o.gdefault = true -- add g flag by default for :substitutions
vim.o.ignorecase = true -- ignore case by default - unless using uppercase/lowercase via smartcase
vim.o.smartcase = true -- ignore 'ignorecase' when search contains uppercase characters
vim.o.grepprg="rg --vimgrep"
vim.o.grepformat="%f:%l:%c:%m"

-- }}}
-- basic ui things{{{

vim.o.list = false -- do not show invisible characters (there's an auto-command to show only in insert mode)
vim.o.listchars = 'tab:->,eol:¬,trail:-,extends:↩,precedes:↪,leadmultispace:···|,' -- define characters for invisible characters
vim.o.fillchars = 'eob:⸱'
vim.o.rnu = true
vim.o.nu = true
vim.o.cursorline = false -- Highlight the line of in which the cursor is present (or not)
vim.o.showtabline = 0 -- tabs are in my statusline
vim.o.scrolloff = 2 -- always have 2 lines more visible when reaching top/end of a window when scrolling
vim.o.background = 'dark'
vim.o.guifont = 'JetBrains Mono:h16'
vim.o.showmatch = true -- Highlight matching bracket
vim.o.showmode = false -- don't show the current mode - lualine handles this
vim.o.signcolumn = 'yes' -- always show signcolumn - prevents horizontal jumping
vim.o.laststatus = 2
vim.o.termguicolors = true -- enable 24bit colors
vim.o.guicursor = "n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor50"

-- }}}
-- indentation and wrapping {{{

vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.textwidth = 80
vim.o.expandtab = true

vim.o.breakindent = true -- wrapped lines appear indendet
vim.o.briopt = 'shift:4' -- indent wrapped lines
vim.o.linebreak = true
vim.o.wrap = false       -- don't wrap by default

-- }}}
-- backup + undo {{{

vim.o.swapfile = false -- disable swap files
vim.o.backupskip = '/tmp/*,/private/tmp/*' -- Make Vim able to edit crontab files again.
vim.o.backup = true -- enable backups
vim.o.backupdir = '/tmp'
vim.o.undofile = true

-- }}}
-- plugin settings etc {{{

vim.g.netrw_altfile = 1 -- make CTRL-^ ignore netrw buffers
vim.g.netrw_banner = 0 -- hide banner
vim.g.netrw_winsize = 33
vim.g.netrw_preview = 1

vim.g.easy_align_delimiters = {
  -- align \, which I often use in bash scripts etc.
  [ [[\]] ]= {
    pattern=      [[\\]],
    left_margin=  1,
    right_margin= 0
  }
}

vim.g.symbols_outline = {
  auto_close = true,
  auto_preview = false,
  show_quides = false
}

vim.g.UltiSnipsExpandTrigger       = "<c-l>"
vim.g.UltiSnipsEditSplit           = "tabdo"

-- }}}

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  pattern = { "*" },
  callback = function()
    vim.api.nvim_exec('silent! normal! g`"zv', false)
  end,
})

require('lazy').setup("plugins", {
  dev = {
    path = '~/code',
    fallback = true
  },
  change_detection = {
    enabled = false, -- I found this annoying when having multiple long running nvim sessions.
  },
})
