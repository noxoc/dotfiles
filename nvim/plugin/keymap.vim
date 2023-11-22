nnoremap _ <cmd>vnew %:h<cr>

nnoremap <esc> <cmd>nohlsearch<cr><cmd>pclose<cr><cmd>echo <cr>

" more undo stops in insert mode
inoremap ! !<c-g>u
inoremap . .<c-g>u
inoremap : :<c-g>u
inoremap ; ;<c-g>u
inoremap ? ?<c-g>u
inoremap , ,<c-g>u

cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" visual select last inserted text
nnoremap gV `[v`] 

" change inside|around all [wW]ords
" word Word
nnoremap ciaw viw*<esc>:%s///<left>
nnoremap ciaW viW*<esc>:%s///<left>
nnoremap caaw vaw*<esc>:%s///<left>
nnoremap caaW vaW*<esc>:%s///<left>

nnoremap <F12> <cmd>Ts<CR>i
tnoremap <F12> <C-\><C-n><cmd>T<CR>

" better terminal exits
tnoremap <c-[> <C-\><C-n>
tnoremap <Esc> <C-\><C-n>

" when moving more than 5 lines , then make a jump, to be able to revert via c-o
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'gj'
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'gk'

nnoremap <leader>dts mz:%s/ \+$//<cr>`z<cr>

nnoremap z0 zMzvzz

nnoremap  <C-d>zz
nnoremap  <C-u>zz

nnoremap <leader>M <cmd>Messages<cr>

nnoremap ]c <cmd>cn<cr>
nnoremap [c <cmd>cp<cr>
nnoremap ]l <cmd>lnext<cr>
nnoremap [l <cmd>lprev<cr>

" split a line in two, making the right above the left (usefull to move comments)
nnoremap X i<cr><esc>ddkP
" the inverse
nnoremap gX ddpkJ  

nnoremap <leader>cc <cmd>Git commit<cr>

" buffer navigation
nnoremap gf <cmd>e <cfile><CR>
nnoremap <silent> <leader>x <cmd>b#\|bd#<cr>
nnoremap <silent> <leader>b0 <cmd>%bd\|e#<cr>

nnoremap <c-n> <cmd>cn<cr>
nnoremap <c-p> <cmd>cp<cr>

nnoremap <leader>it <cmd>TSHighlightCapturesUnderCursor<cr>

nnoremap <leader>tn <cmd>Num<cr>
nnoremap <leader>tg <cmd>Gitsigns toggle_signs<cr>
nnoremap <leader>td <cmd>DoToggle<cr>
nnoremap <leader>tb <cmd>BG<cr>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nmap <leader>f <cmd>Telescope find_files hidden=true<cr>
nmap <leader>F <cmd>Telescope find_files hidden=true<cr>
nmap <leader><c-f> <cmd>Telescope find_files hidden=true cwd=%:p:h<cr>
nmap <leader>* <cmd>Telescope grep_string<cr>
nmap <leader>g <cmd>Telescope live_grep<cr>
nmap <leader>G <cmd>Telescope live_grep cwd=%:p:h<cr>
nmap <leader>: <cmd>Telescope commands<cr>
nmap <leader><c-r> <cmd>Telescope command_history<cr>
nmap <leader><cr> <cmd>Telescope resume<cr>
nmap <leader>hh <cmd>Telescope help_tags<cr>
nmap <leader>S <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
nmap <leader><leader> <cmd>Telescope buffers<cr>
nmap <leader>s <cmd>Telescope lsp_document_symbols<cr>
nmap <leader>C <cmd>Telescope colorscheme enable_preview=true<cr>
nmap <leader>T <cmd>Telescope builtin<cr>
nmap <leader>/ <cmd>Telescope current_buffer_fuzzy_find<cr>

xnoremap ga         <Plug>(EasyAlign)
nnoremap ga         <Plug>(EasyAlign)
nnoremap <leader>m  <cmd>lua require("treesj").toggle()<cr>
nnoremap <leader>tu <cmd>MundoToggle<CR>
nnoremap [h         <cmd>Gitsigns prev_hunk<CR>
nnoremap ]h         <cmd>Gitsigns next_hunk<CR>
nnoremap <leader>hD <cmd>lua require "gitsigns".diffthis("~")<cr>
nnoremap <leader>hR <cmd>lua require("gitsigns.actions").reset_buffer()<cr>
nnoremap <leader>hS <cmd>lua require("gitsigns.actions").stage_buffer()<cr>
nnoremap <leader>hb <cmd>lua require("gitsigns").blame_line { full=true }<cr>
nnoremap <leader>hd <cmd>lua require("gitsigns.actions").diffthis()<cr>
nnoremap <leader>hp <cmd>lua require("gitsigns.actions").preview_hunk()<cr>
nnoremap <leader>hr <cmd>lua require("gitsigns.actions").reset_hunk()<cr>
nnoremap <leader>hs <cmd>lua require("gitsigns.actions").stage_hunk()<cr>
nnoremap <leader>hu <cmd>lua require("gitsigns.actions").undo_stage_hunk()<cr>

 onoremap ic <cmd>lua require("gitsigns.actions").select_hunk()<cr>
 xnoremap ic <cmd>lua require("gitsigns.actions").select_hunk()<cr>

nmap [[ ?{<CR>w99[{
nmap ][ /}<CR>b99]}
nmap ]] j0[[%/{<CR>
nmap [] k$][%?}<CR>

nnoremap <M-s> :w<cr>
nnoremap <D-s> :w<cr>
inoremap <M-s> <cmd>w<cr><esc>
inoremap <D-s> <cmd>w<cr><esc>

nnoremap <C-1> 1gt
nnoremap <C-2> 2gt
nnoremap <C-3> 3gt
nnoremap <C-4> 4gt
nnoremap <C-5> 5gt
