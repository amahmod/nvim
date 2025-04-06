local map = vim.keymap.set

-- File operations {{{

-- Use Space + w/q for most common operations (save/quit)
map('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save' })
map('n', '<leader>q', '<cmd>q!<CR>', { desc = 'Quit' })
-- Add Ctrl-s as an alternative for save (common in other editors)
map({ 'n', 'i', 'v' }, '<C-s>', '<cmd>w<CR>', { desc = 'Save' })

-- Buffer operations - use 'b' prefix for consistency
map('n', '<leader>x', function()
    local has_bufremove, bufremove = pcall(require, 'mini.bufremove')
    if has_bufremove then
        bufremove.delete(0, false)
    else
        vim.cmd 'bd'
    end
end, { desc = 'Delete buffer' })
map('n', '<leader>ba', '<cmd>bufdo bd<CR>', { desc = 'Delete all buffers' })
map('n', '<leader>bo', '<cmd>w <bar> %bd <bar> e# <bar> bd#<CR>', { desc = 'Delete other buffers' })
map('n', '<S-l>', '<cmd>bnext<CR>', { desc = 'Go to next buffer' })
map('n', '<S-h>', '<cmd>bprevious<CR>', { desc = 'Go to previous buffer' })

-- }}}

-- {{{ Core Navigation
-- Split navigation - Ctrl + hjkl is very natural for vim users
map('n', '<C-h>', '<C-w>h', { desc = 'Focus left split' })
map('n', '<C-j>', '<C-w>j', { desc = 'Focus down split' })
map('n', '<C-k>', '<C-w>k', { desc = 'Focus up split' })
map('n', '<C-l>', '<C-w>l', { desc = 'Focus right split' })

-- Buffer navigation - Alt + hl for quick buffer switching
-- Alt is easier to reach than Shift
map('n', '<A-h>', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })
map('n', '<A-l>', '<cmd>bnext<CR>', { desc = 'Next buffer' })

-- Command line navigation - consistent with normal mode navigation
map('c', '<C-h>', '<Left>', { desc = 'Move left' })
map('c', '<C-l>', '<Right>', { desc = 'Move right' })
map('c', '<C-j>', '<End>', { desc = 'Move to end' })
map('c', '<C-k>', '<Home>', { desc = 'Move to start' })

-- Better up/down on wrapped lines
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Center cursor when scrolling/searching
map('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down and center' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up and center' })
map('n', '*', '*zzzv', { desc = 'Search word under cursor and center' })
map('n', '#', '#zzzv', { desc = 'Search word under cursor backwards and center' })

-- Improved search navigation with cursor centering
map('n', 'n', "'Nn'[v:searchforward].'zvzz'", { expr = true, desc = 'Next search result' })
map('n', 'N', "'nN'[v:searchforward].'zvzz'", { expr = true, desc = 'Prev search result' })

-- }}}

-- {{{ Editing Operations
-- Indentation - Simple and familiar
map('x', '<', '<gv', { desc = 'Indent left and reselect' })
map('x', '>', '>gv', { desc = 'Indent right and reselect' })
map('x', '<Tab>', '>gv', { desc = 'Indent right' })
map('x', '<S-Tab>', '<gv', { desc = 'Indent left' })

-- Join lines without moving cursor
map('n', 'J', 'mzJ`z', { desc = 'Join lines and keep cursor' })

-- Break undo sequence on specific characters
map('i', ',', ',<C-g>u', { desc = 'Break undo at comma' })
map('i', '.', '.<C-g>u', { desc = 'Break undo at period' })
map('i', ';', ';<C-g>u', { desc = 'Break undo at semicolon' })

-- Redo with U (opposite of u for undo)
map('n', 'U', '<C-r>', { desc = 'Redo' })
-- }}}

-- {{{ Clipboard Operations
-- System clipboard operations (y = yank, p = paste)
map({ 'n', 'x' }, '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
map({ 'n', 'x' }, '<leader>Y', '"+Y', { desc = 'Copy line to system clipboard' })
map({ 'n', 'x' }, '<leader>p', '"+p', { desc = 'Paste from system clipboard' })
map({ 'n', 'x' }, '<leader>P', '"+P', { desc = 'Paste from system clipboard before' })

-- Smart paste in visual mode - preserves the yanked text
map('x', 'p', 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = 'Paste and preserve' })
map('x', 'P', 'P:let @+=@0<CR>:let @"=@0<CR>', { desc = 'Paste before and preserve' })

-- Path operations
map('n', '<leader>yp', function()
    local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':~:.')
    vim.fn.setreg('+', path)
    vim.notify('Copied: ' .. path, vim.log.levels.INFO)
end, { desc = 'Copy relative path' })

map('n', '<leader>yP', function()
    local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':p')
    vim.fn.setreg('+', path)
    vim.notify('Copied: ' .. path, vim.log.levels.INFO)
end, { desc = 'Copy absolute path' })

-- Keep cursor at the bottom of the visual selection
map('v', 'y', 'ygv<Esc>', { desc = 'Yank and keep cursor position' })

-- Paste over selection without copying it
map('x', 'p', '"_dP', { desc = 'Paste over selection without copying' })

-- }}}

-- {{{ Toggle Operations
-- Use 't' prefix for toggles
map('n', '<leader>tb', function()
    vim.opt.background = vim.opt.background:get() == 'dark' and 'light' or 'dark'
    vim.notify('Background: ' .. vim.opt.background:get())
end, { desc = 'Toggle background' })

map('n', '<leader>tw', function()
    vim.opt.wrap = not vim.opt.wrap:get()
    vim.notify('Wrap: ' .. (vim.opt.wrap:get() and 'ON' or 'OFF'))
end, { desc = 'Toggle word wrap' })

map('n', '<leader>ts', function()
    vim.opt.spell = not vim.opt.spell:get()
    vim.notify('Spell: ' .. (vim.opt.spell:get() and 'ON' or 'OFF'))
end, { desc = 'Toggle spell check' })

-- Invisibles (whitespace characters)
map('n', '<leader>ti', function()
    vim.opt.list = not vim.opt.list:get()
    vim.notify('Show invisibles: ' .. (vim.opt.list:get() and 'ON' or 'OFF'))
end, { desc = 'Toggle invisible characters' })

-- Line cursor
map('n', '<leader>tc', function()
    vim.opt.cursorline = not vim.opt.cursorline:get()
    vim.notify('Cursor line: ' .. (vim.opt.cursorline:get() and 'ON' or 'OFF'))
end, { desc = 'Toggle cursor line' })

-- Diagnostics
map('n', '<leader>td', function()
    local current = vim.diagnostic.is_disabled()
    if current then
        vim.diagnostic.enable()
        vim.notify 'Diagnostics: ON'
    else
        vim.diagnostic.disable()
        vim.notify 'Diagnostics: OFF'
    end
end, { desc = 'Toggle diagnostics' })
-- }}}

-- vim:fdm=marker:fdl=0
