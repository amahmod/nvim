local opt = vim.opt

-- ───────────────────────────────( Searching )────────────────────────────
opt.ignorecase = true -- Search ignoring case
opt.smartcase = true -- Keep case when searching with *
opt.incsearch = true -- Incremental search
opt.inccommand = 'split'
opt.grepformat = '%f:%l:%c:%m'

-- ───────────────────────────────( Undo/Redo )────────────────────────────
opt.swapfile = false
opt.undofile = true -- Persistent undo
opt.undolevels = 10000
opt.writebackup = false -- Don't make a backup before overwriting a file

-- ────────────────────────────( Formatting )─────────────────────────
opt.expandtab = true -- Expand tabs to spaces
opt.shiftround = true -- Round indent
opt.shiftwidth = 4 -- Size of an indent
opt.smartindent = true -- Smart indent
opt.splitbelow = true -- Splits open bottom right
opt.splitright = true
opt.tabstop = 4 -- Number of spaces tabs count for
opt.wrap = false -- No wrap by default
-- Don't have `o` add a comment
opt.formatoptions:remove 'o'

-- ─────────────────────────────( Editor UI )─────────────────────────────
opt.sidescrolloff = 5 -- Keep at least 5 lines left/right
opt.number = true -- Show line number
opt.relativenumber = true -- Show relative line numbers
opt.list = true -- Show hidden characters
opt.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time

opt.showtabline = 0 -- Always show the tabs line
opt.winwidth = 30 -- Minimum width for active window
opt.winminwidth = 1 -- Minimum width for inactive windows
opt.winheight = 1 -- Minimum height for active window
opt.winminheight = 1 -- Minimum height for inactive window
opt.winbar = '%m %f'

opt.equalalways = true -- Resize windows on split or close
-- opt.cmdwinheight = 5 -- Command                                      -line lines
-- opt.cmdheight = 0
-- opt.colorcolumn = '+0' -- Column highlight at textwidth's max character-limit
-- opt.cursorline = true -- Highlight current line
-- opt.pumheight = 10 -- Maximum number of items to show in the popup menu
-- opt.pumwidth = 10 -- Minimum width for the popup menu
-- opt.pumblend = 10 -- Popup blend

-- ──────────────────────────────( Folding )──────────────────────────────
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

-- ─────────────────────────────( Filetype )──────────────────────────
vim.filetype.add {
    filename = {
        ['yarn.lock'] = 'yaml',
        ['.jsbeautifyrc'] = 'json',
        ['.jscsrc'] = 'json',
    },
    extension = {
        pcss = 'css',
    },
    pattern = {
        ['.*%.js%.map'] = 'json',
        ['.*%.postman_collection'] = 'json',
        ['Jenkinsfile.*'] = 'groovy',
    },
}
