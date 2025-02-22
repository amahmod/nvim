local map = vim.keymap.set
local opts = { noremap = true, silent = true }


-- stylua: ignore start

--  System clipboard copy/paste {{{
-- Copy to system clipboard
map({ 'n', 'x' }, '<leader>y', '"+y', opts)
-- Paste from system clipboard
map({ 'n', 'x' }, '<leader>p', '"+p', opts)

-- Yank buffer's relative path to clipboard
map('n', '<leader>yr', function() local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':~:.') vim.fn.setreg('+', path) vim.notify(path, vim.log.levels.INFO, { title = 'Yanked relative path' }) end, { silent = true, desc = 'Yank relative path' })

-- Yank absolute path
map('n', '<leader>ya', function() local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':p') vim.fn.setreg('+', path) vim.notify(path, vim.log.levels.INFO, { title = 'Yanked absolute path' }) end, { silent = true, desc = 'Yank absolute path' })

-- Paste in visual-mode without pushing to register
map('x', 'p', 'p:let @+=@0<CR>:let @"=@0<CR>', opts)
map('x', 'P', 'P:let @+=@0<CR>:let @"=@0<CR>', opts)

-- }}}

-- Save and quit {{{

map( { 'n', 'v' }, '<leader>bo', "<cmd>lua require('vscode').action('workbench.action.closeOtherEditors')<CR>")
map( { 'n', 'v' }, '<leader>ba', "<cmd>lua require('vscode').action('workbench.action.closeAllEditors')<CR>")
map( { 'n', 'v' }, '<leader>x', "<cmd>lua require('vscode').action('workbench.action.closeActiveEditor')<CR>")
map('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save' })

-- }}}

-- Harpoon keymaps {{{
map({ 'n', 'v' }, '<leader>ha', "<cmd>lua require('vscode').action('vscode-harpoon.addEditor')<CR>")
map( { 'n', 'v' }, '<leader>ho', "<cmd>lua require('vscode').action('vscode-harpoon.editorQuickPick')<CR>")
map( { 'n', 'v' }, '<leader>he', "<cmd>lua require('vscode').action('vscode-harpoon.editEditors')<CR>")
map( { 'n', 'v' }, '<leader>1', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor1')<CR>")
map( { 'n', 'v' }, '<leader>2', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor2')<CR>")
map( { 'n', 'v' }, '<leader>3', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor3')<CR>")
map( { 'n', 'v' }, '<leader>4', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor4')<CR>")
map( { 'n', 'v' }, '<leader>5', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor5')<CR>")
map( { 'n', 'v' }, '<leader>6', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor6')<CR>")
map( { 'n', 'v' }, '<leader>7', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor7')<CR>")
map( { 'n', 'v' }, '<leader>8', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor8')<CR>")
map( { 'n', 'v' }, '<leader>9', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor9')<CR>")
-- }}}

-- LSP {{{
map({ 'n', 'v' }, '<leader>ca', "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>")
map({ 'n', 'v' }, '<leader>rn', "<cmd>lua require('vscode').action('editor.action.rename')<CR>")
map( { 'n', 'v' }, '<leader>ls', "<cmd>lua require('vscode').action('workbench.action.gotoSymbol')<CR>")
map( { 'n', 'v' }, '<leader>lS', "<cmd>lua require('vscode').action('workbench.action.showAllSymbols')<CR>")
map( { 'n', 'v' }, '<leader>lf', "<cmd>lua require('vscode').action('editor.action.formatDocument')<CR>")
-- go to implementation
map({ 'n', 'v' }, 'gi', "<cmd>lua require('vscode').action('editor.action.goToImplementation')<CR>")
map({ 'n', 'v' }, ']d', "<cmd>lua require('vscode').action('editor.action.marker.next')<CR>")
map({ 'n', 'v' }, '[d', "<cmd>lua require('vscode').action('editor.action.marker.prev')<CR>")
map({ 'n', 'v' }, ']D', "<cmd>lua require('vscode').action('editor.action.marker.nextInFiles')<CR>")
map({ 'n', 'v' }, '[D', "<cmd>lua require('vscode').action('editor.action.marker.prevInFiles')<CR>")
-- }}}

-- Folding {{{
-- Folding toggle and level-based commands
map('n', 'za', "<Cmd>call VSCodeNotify('editor.toggleFold')<CR>", opts)
map('n', 'zR', "<Cmd>call VSCodeNotify('editor.unfoldAll')<CR>", opts)
map('n', 'zM', "<Cmd>call VSCodeNotify('editor.foldAll')<CR>", opts)
map('n', 'zo', "<Cmd>call VSCodeNotify('editor.unfold')<CR>", opts)
map('n', 'zO', "<Cmd>call VSCodeNotify('editor.unfoldRecursively')<CR>", opts)
map('n', 'zc', "<Cmd>call VSCodeNotify('editor.fold')<CR>", opts)
map('n', 'zC', "<Cmd>call VSCodeNotify('editor.foldRecursively')<CR>", opts)

-- Fold level commands
map('n', 'z1', "<Cmd>call VSCodeNotify('editor.foldLevel1')<CR>", opts)
map('n', 'z2', "<Cmd>call VSCodeNotify('editor.foldLevel2')<CR>", opts)
map('n', 'z3', "<Cmd>call VSCodeNotify('editor.foldLevel3')<CR>", opts)
map('n', 'z4', "<Cmd>call VSCodeNotify('editor.foldLevel4')<CR>", opts)
map('n', 'z5', "<Cmd>call VSCodeNotify('editor.foldLevel5')<CR>", opts)
map('n', 'z6', "<Cmd>call VSCodeNotify('editor.foldLevel6')<CR>", opts)
map('n', 'z7', "<Cmd>call VSCodeNotify('editor.foldLevel7')<CR>", opts)

map('n', 'zj', "<Cmd>call VSCodeNotify('editor.gotoNextFold')<CR>", opts)
map('n', 'zk', "<Cmd>call VSCodeNotify('editor.gotoPreviousFold')<CR>", opts)

-- Fold all except the selection
map('x', 'zV', "<Cmd>call VSCodeNotify('editor.foldAllExcept')<CR>", opts)
-- }}}

-- Misc {{{
map( { 'n', 'v' }, 'L', "<cmd>lua require('vscode').action('workbench.action.nextEditorInGroup')<CR>")
map( { 'n', 'v' }, 'H', "<cmd>lua require('vscode').action('workbench.action.previousEditorInGroup')<CR>")
map( { 'n', 'v' }, '<leader>e', "<cmd>lua require('vscode').action('workbench.action.toggleSidebarVisibility')<CR>")


-- better indent handling
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

-- move text up and down
map('v', 'J', ':m .+1<CR>==', opts)
map('v', 'K', ':m .-2<CR>==', opts)
map('x', 'J', ":move '>+1<CR>gv-gv", opts)
map('x', 'K', ":move '<-2<CR>gv-gv", opts)

-- }}}
