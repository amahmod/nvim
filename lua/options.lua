local opt = vim.opt

-- ───────────────────────────────( Files )────────────────────────────────
opt.swapfile = false
opt.undofile = true -- Persistent undo
opt.undolevels = 10000
opt.writebackup = false -- Don't make a backup before overwriting a file

-- ───────────────────────────────( Search )────────────────────────────────
opt.ignorecase = true -- Search ignoring case
opt.smartcase = true -- Keep case when searching with *
opt.incsearch = true -- Incremental search
opt.inccommand = 'split'
opt.grepformat = '%f:%l:%c:%m'

-- ───────────────────────────────( Indentation )────────────────────────────
opt.expandtab = true -- Expand tabs to spaces
opt.shiftround = true -- Round indent
opt.shiftwidth = 4 -- Size of an indent
opt.smartindent = true -- Smart indent
opt.tabstop = 4 -- Number of spaces tabs count for

-- ───────────────────────────────( Window Management )────────────────────────────
opt.splitbelow = true -- Splits open bottom right
opt.splitright = true
opt.equalalways = true -- Resize windows on split or close

-- ───────────────────────────────( UI Elements )────────────────────────────
opt.number = true -- Show line number
opt.relativenumber = true -- Show relative line numbers
opt.signcolumn = 'yes' -- Always show the signcolumn
opt.list = true -- Show hidden characters
opt.wrap = false -- No wrap by default
opt.winbar = '%m %f'
opt.sidescrolloff = 5 -- Keep at least 5 lines left/right
opt.cursorline = true -- Highlight current line

-- ───────────────────────────────( Editor Behavior )────────────────────────────
opt.spell = true
opt.formatoptions:remove 'o' -- Don't add comment leader on 'o'

-- ───────────────────────────────( Folding )────────────────────────────
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

-- ───────────────────────────────( Filetype Detection )────────────────────────────
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
