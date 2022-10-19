local function map(mode, key, command, opts)
  opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
  vim.keymap.set(mode, key, command, opts)
end

-- Prefixes for description {{{
-- also used to create a coherent mapping system
local prefix = function(s)
  return function(suffix)
    return { desc = s .. " " .. suffix }
  end
end

local b = prefix "[b]uffer"
local d = prefix "[d]ebug"
local h = prefix "[h]unk"
local s = prefix "[s]earch"
local t = prefix "[t]oggle"
local x = prefix "[x] globals"
local z = prefix "[z]ettel"
--}}}
-- Window navigation {{{
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-l>', '<c-w>l')
map('n', '<c-h>', '<c-w>h')
map('n', 'ñ', 'gt') -- alt n
map('n', 'œ', 'gT') -- alt p
--}}}
-- Telescope and file finding {{{
local st = ":lua require('snock.plugins.telescope')"

map('n', '<leader><space>', st .. ".buffers()<cr>", { desc = '[ ] Find existing buffers' })
map('n', '<leader><cr>', st .. ".resume()<cr>", { desc = '[] resume previous search' })
map('n', '<leader>T', st .. ".builtin()<cr>", { desc = 'builtin [T]elescope commands' })
map('n', '<M-p>', st .. ".search_in(nil)<cr>", s('[f]iles'))
map('n', '<leader>sC', st .. ".colorscheme({ enable_preview = true })<cr>", s("[C]olors"))

map('n', '<leader>sf', st .. ".search_in(nil)<cr>", s('[f]iles'))
map('n', '<leader>sdf', st .. ".search_in(vim.fn.getenv('DOTDIR'))<cr>", s('[d]ot[f]iles'))
map('n', '<leader>sr', st .. ".oldfiles()<cr>", s('[r]ecently opened files'))
map('n', '<leader>sR', st .. ".reloader()<cr>", s('[R]eload lua packages'))
map('n', '<leader>sh', st .. ".help_tags()<cr>", s('[h]elp'))
map('n', '<leader>sk', st .. ".keymaps()<cr>", s('[k]eymaps'))
map('n', '<leader>sc', st .. ".commands()<cr>", s('[c]ommands'))
map('n', '<leader>sw', st .. ".grep_string()<cr>", s('current [w]ord'))
map('n', '<leader>sg', st .. ".live_grep()<cr>", s('by [g]rep'))
map('n', '<leader>sb', st .. ".git_branches()<cr>")
map('n', '<leader>/', st .. '.current_buffer_fuzzy_find()<cr>', { desc = '[/] Fuzzily search in current buffer' })
map('n', '<leader>sp', ":lua R('snock.plugins.search-plugins').search()<cr>", s('[p]lugins'))
map('n', '<M-C-P>', st .. ".commands()<cr>", s('[c]ommands'))
--}}}
-- Buffer {{{
map('n', '<leader>bd', ':b#|bd#<cr>', b("[D]elete    , keep layout"))
map('n', '<leader>bD', ':bd', b("[D]elete"))
map('n', '<leader>bO', ':%bd|e#<cr>', b("[O]nly"))
--}}}
-- Terminal {{{
map('n', '<F12>', ':Ts<CR>i')
map('n', '<M-j>', ':Ts<CR>i')
map('t', '<F12>', [[<C-\><C-n>:T<CR>]])
map('t', '<M-j>', [[<C-\><C-n>:T<CR>]])

-- better terminal exits
map('t', '<c-[>', '<C-\\><C-n>')
map('t', '<Esc>', '<C-\\><C-n>')
-- }}}
-- Debugging{{{
map('n', '<leader>db', ':DapToggleBreakpoint<cr>', d('toggle [b]reakpoint'))
map('n', '<leader>du', ':lua require("dapui").toggle()<cr>', d("toggle [u]i"))
map('n', '<leader>dc', ':DapContinue<cr>', d("[c]ontinue"))
map('n', '<leader>di', ':DapStepInto<cr>', d("step [i]nto"))
map('n', '<leader>do', ':DapStepOver<cr>', d("step [o]ver"))
map('n', '<leader>dO', ':DapStepOut<cr>', d("step [O]ut"))
map('n', '<leader>dl', ':DapRunLast<cr>', d("Run [l]ast"))
--}}}
-- Diagnostics {{{
map('n', '<leader>xd', ':Trouble document_diagnostics<CR>', x "show [d]ocument_diagnostics")
map('n', '<leader>xD', ':Trouble workspace_diagnostics<CR>', x "show workspace_[D]iagnostics")
map('n', '<leader>xt', ':TodoTrouble<CR>', x "[t]odos")
map('n', '<leader>k', vim.diagnostic.goto_prev)
map('n', '<leader>j', vim.diagnostic.goto_next)
map('n', '<leader>e', vim.diagnostic.open_float)
map('n', '<leader>q', vim.diagnostic.setloclist)
map('n', "<leader>K", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end)
map('n', "<leader>J", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end)
-- }}}

-- Harpoon {{{
-- file nav
map('n', "<leader>'", ':lua require("harpoon.mark").add_file()<CR>')
map('n', "''", ':lua require("harpoon.ui").toggle_quick_menu()<CR>')
map('n', "è", ':lua require("harpoon.ui").nav_file(1)<CR>')
map('n', "đ", ':lua require("harpoon.ui").nav_file(2)<CR>')
map('n', "ß", ':lua require("harpoon.ui").nav_file(3)<CR>')
map('n', "ä", ':lua require("harpoon.ui").nav_file(4)<CR>')

-- cmd
map('n', '""', ':lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>')
map('n', '"1', ':lua require("harpoon.tmux").gotoTerminal(1)<CR>')
map('n', '"2', ':lua require("harpoon.tmux").gotoTerminal(2)<CR>')
--}}}
-- Git hunk handling {{{
local gitsigns = require('gitsigns.actions')

map('n', '<leader>gg', ':tab G<cr>')
map('n', '<leader>gs', ':Telescope git_status<cr>')
map('n', ']h', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
map('n', '[h', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })
map('n', '<leader>hs', gitsigns.stage_hunk, h '[s]tage')
map('v', '<leader>hs', gitsigns.stage_hunk, h '[s]tage')
map('n', '<leader>hr', gitsigns.reset_hunk, h '[r]eset')
map('v', '<leader>hr', gitsigns.reset_hunk, h '[r]eset')
map('n', '<leader>hu', gitsigns.undo_stage_hunk, h '[U]ndo stage')
map('n', '<leader>hS', gitsigns.stage_buffer, h '[S]tage buffer')
map('n', '<leader>hR', gitsigns.reset_buffer, h '[R]eset buffer')
map('n', '<leader>hp', gitsigns.preview_hunk)
map('n', '<leader>hb', ':lua require"gitsigns".blame_line{full=true}<CR>')
map('n', '<leader>hd', gitsigns.diffthis)
map('n', '<leader>hD', ':lua require"gitsigns".diffthis("~")<CR>')
map('o', 'ih', gitsigns.select_hunk)
map('x', 'ih', gitsigns.select_hunk)
-- }}}
-- Zettelkasten{{{
local zettel = ':lua require("zettel")'
map('n', '<leader>zf', zettel .. '.find_notes()<cr>', z('[f]ind notes'))
map('n', '<leader>zd', zettel .. '.find_daily_notes()<cr>', z('find [d]aily notes'))
map('n', '<leader>zg', zettel .. '.search_notes()<cr>', z('[g]rep notes'))
map('n', '<leader>zz', zettel .. '.follow_link()<cr>', z('[z] follow link'))
map('n', '<leader>zt', zettel .. '.goto_today()<cr>', z('goto [t]oday'))
map('n', '<leader>zW', zettel .. '.goto_thisweek()<cr>', z('goto this [W]eek'))
map('n', '<leader>zw', zettel .. '.find_weekly_notes()<cr>', z('find [w]eekly notes'))
map('n', '<leader>zn', zettel .. '.new_note()<cr>', z('[n]ew note'))
map('n', '<leader>zN', zettel .. '.new_templated_note()<cr>', z('[N]ew templated note'))
--}}}
-- Toggles {{{
map('n', '<leader>te', ':NnnExplorer<cr>', t('[e]xplorer (nnn)'))
map('n', '<leader>tE', ':NnnExplorer %:p:h<cr>', t('[E]xplorer in buffer folder (nnn)'))
map('n', '_', ':NnnPicker %:p:h<cr>')
map('n', '<M-b>', ':lua require("nvim-tree.api").tree.toggle()<CR>', { desc = "[t]ree [t]oggle" })
map('n', '<leader>tt', ':lua require("nvim-tree.api").tree.toggle()<CR>', { desc = "[t]ree [t]oggle" })
map('n', '<leader>tn', ':LineNrToggle<CR>', { desc = "[t]oggle line [n]umbers" })
map('n', '<leader>tu', ':MundoToggle<CR>', { desc = "[t]oggle [u]ndo tree" })
map('n', '<leader>to', ':SymbolsOutline<cr>', { desc = "[t]oggle [o]utline" })
--}}}
-- Misc convenience {{{
-- more undo stops in insert mode {{{
map('i', '!', '!<c-g>u')
map('i', '.', '.<c-g>u')
map('i', ':', ':<c-g>u')
map('i', ';', ';<c-g>u')
map('i', '?', '?<c-g>u')
map('i', ',', ',<c-g>u')
--}}}
-- infos {{{
map('n', '<leader>it', ':TSHighlightCapturesUnderCursor<cr>')
map('n', '<leader>id', '<Plug>:LspDiagLine<cr>')
--}}}

-- when moving more than 5 lines , then make a jump , to be able to revert via c-o
map('n', 'j', [[(v:count > 5 ? "m'" . v:count : "") . 'gj']], { expr = true })
map('n', 'k', [[(v:count > 5 ? "m'" . v:count : "") . 'gk']], { expr = true })

map('n', '<leader>sns', ':source ~/.config/nvim/plugin/completion.lua<cr>', { desc = "[sn]ippet [s]ource" })
map('n', 'gx', ":execute '!open ' . shellescape(expand('<cWORD>')    , 1)<cr>")
map('n', '<leader>M', '<cmd>Messages<cr>', { desc = "[M]essages" })
map('n', '<leader>dts', [[mz:%s/ \+$//<cr>`z<cr>]]) -- delete trailing spaces
map('n', '<leader>cl', ':<c-u>:nohlsearch<cr>:pclose<cr><c-l>', { desc = "[cl]ear display" })
map({ 'i', 'n' }, '<M-s>', '<cmd>:Format<cr>:FixAll<cr>:w<cr>', { silent = true })
map('n', 'z0', 'zMzvzz')
map('n', 'ì', 'zMzvzz') -- alt v
map('n', 'à', 'za') -- alt z
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', "<C-d>", "<C-d>zz")
map('n', "<C-u>", "<C-u>zz")

-- Refactoring {{{

-- prompt for a refactor to apply when the remap is triggered
vim.api.nvim_set_keymap( "v", "<leader>rr", ":lua require('refactoring').select_refactor()<CR>", {noremap = true, silent = true, expr = false })

-- Remaps for the refactoring operations currently offered by the plugin
vim.api.nvim_set_keymap("v", "<leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], {noremap = true, silent = true, expr = false})

-- Extract block doesn't need visual mode
vim.api.nvim_set_keymap("n", "<leader>rb", [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<leader>rbf", [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]], {noremap = true, silent = true, expr = false})

-- Inline variable can also pick up the identifier currently under the cursor without visual mode
vim.api.nvim_set_keymap("n", "<leader>ri", [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], {noremap = true, silent = true, expr = false})-- }}}

map('n', '<leader>cp', ':Format<cr>')
map('n', '<leader>.', ':Telescop code_action<cr>')

map('n', 'gV', '`[v`]') -- visual select last inserted text)

map('n', '<leader>gc', ':normal yygccp<cr>')
map('n', '<leader>gC', ':normal yipgcipP<cr>')

-- move text around
map('v', '<c-k>', ":m '<-2<CR>gv=gv")
map('v', '<c-j>', ":m '>+1<CR>gv=gv")

-- type %% in vim's prompt to insert %:h expanded
--vim.cmd([[cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%']])

map('x', 'ga', '<Plug>(EasyAlign)')
map('n', 'ga', '<Plug>(EasyAlign)')

-- }}}

-- vim: nowrap fen fdl=0
