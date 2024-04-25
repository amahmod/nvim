local user_settings = require 'config.settings'

vim.g.mapleader = ' '

local opt = vim.opt

--         ╔══════════════════════════════════════════════════════════╗
--         ║                         General                          ║
--         ╚══════════════════════════════════════════════════════════╝

opt.mouse = 'nv' -- Disable mouse in command-line mode
opt.hidden = true -- Hide buffers when abandoned instead of unload
opt.virtualedit = 'block' -- Position cursor anywhere in visual block
opt.confirm = true -- Confirm to save changes before exiting modified buffer

--         ╔══════════════════════════════════════════════════════════╗
--         ║                          Timing                          ║
--         ╚══════════════════════════════════════════════════════════╝
opt.ttimeout = true
opt.timeoutlen = 500 -- Time out on mappings
opt.ttimeoutlen = 10 -- Time out on key codes
opt.updatetime = 500 -- Idle time to write swap and trigger CursorHold

--         ╔══════════════════════════════════════════════════════════╗
--         ║                           Undo                           ║
--         ╚══════════════════════════════════════════════════════════╝
opt.undofile = true -- Persistent undo
opt.undolevels = 10000
opt.writebackup = false -- Don't make a backup before overwriting a file

opt.spelloptions:append 'camel'

--         ╔══════════════════════════════════════════════════════════╗
--         ║                        Formatting                        ║
--         ╚══════════════════════════════════════════════════════════╝

opt.expandtab = true -- Expand tabs to spaces
opt.shiftround = true -- Round indent
opt.shiftwidth = 4 -- Size of an indent
opt.smartindent = true -- Smart indent
opt.splitbelow = true -- Splits open bottom right
opt.splitright = true
opt.tabstop = 4 -- Number of spaces tabs count for
opt.wrap = false -- No wrap by default
opt.formatoptions = opt.formatoptions
    - 'a' -- Auto formatting is BAD.
    - 't' -- Don't auto format my code. I got linters for that.
    + 'c' -- In general, I like it when comments respect textwidth
    + 'q' -- Allow formatting comments w/ gq
    - 'o' -- O and o, don't continue comments
    + 'r' -- But do continue when pressing enter.
    + 'n' -- Indent past the formatlistpat, not underneath it.
    + 'j' -- Auto-remove comments if possible.
    - '2' -- I'm not in gradeschool anymore

--         ╔══════════════════════════════════════════════════════════╗
--         ║                         Searching                        ║
--         ╚══════════════════════════════════════════════════════════╝

opt.ignorecase = true -- Search ignoring case
opt.smartcase = true -- Keep case when searching with *
opt.incsearch = true -- Incremental search
opt.inccommand = 'split'
opt.grepformat = '%f:%l:%c:%m'

--         ╔══════════════════════════════════════════════════════════╗
--         ║                        Editor UI                         ║
--         ╚══════════════════════════════════════════════════════════╝

opt.termguicolors = true -- True color support
opt.shortmess:append { W = true, I = true, c = true }
opt.showmode = false -- Don't show mode in cmd window
opt.scrolloff = 999 -- Keep at least 2 lines above/below
opt.sidescrolloff = 5 -- Keep at least 5 lines left/right
opt.numberwidth = 1 -- Minimum number of columns to use for the line number
opt.number = true -- Show line number
opt.relativenumber = true -- Show relative line numbers
opt.ruler = false -- Disable default status ruler
opt.list = true -- Show hidden characters
opt.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time

opt.showtabline = 0 -- Always show the tabs line
opt.winwidth = 30 -- Minimum width for active window
opt.winminwidth = 1 -- Minimum width for inactive windows
opt.winheight = 1 -- Minimum height for active window
opt.winminheight = 1 -- Minimum height for inactive window
opt.winbar = '%m %f'

opt.cmdwinheight = 5 -- Command                                      -line lines
opt.equalalways = true -- Resize windows on split or close
opt.colorcolumn = '+0' -- Column highlight at textwidth's max character-limit

opt.cursorline = true -- Highlight current line

opt.pumheight = 10 -- Maximum number of items to show in the popup menu
opt.pumwidth = 10 -- Minimum width for the popup menu
opt.pumblend = 10 -- Popup blend

--         ╔══════════════════════════════════════════════════════════╗
--         ║                          Folds                           ║
--         ╚══════════════════════════════════════════════════════════╝

opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

if user_settings.treesitter_folds then
    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
end

--         ╔══════════════════════════════════════════════════════════╗
--         ║                  Filetype Detection                      ║
--         ╚══════════════════════════════════════════════════════════╝

---@diagnostic disable-next-line: missing-fields
vim.filetype.add {
    filename = {
        Brewfile = 'ruby',
        justfile = 'just',
        Justfile = 'just',
        Tmuxfile = 'tmux',
        postcss = 'css',
        ['yarn.lock'] = 'yaml',
        ['.buckconfig'] = 'toml',
        ['.flowconfig'] = 'ini',
        ['.jsbeautifyrc'] = 'json',
        ['.jscsrc'] = 'json',
        ['.watchmanconfig'] = 'json',
        ['dev-requirements.txt'] = 'requirements',
    },
    extension = {
        pcss = 'css',
    },
    pattern = {
        ['.*%.js%.map'] = 'json',
        ['.*%.postman_collection'] = 'json',
        ['Jenkinsfile.*'] = 'groovy',
        ['%.kube/config'] = 'yaml',
        ['%.config/git/users/.*'] = 'gitconfig',
        ['requirements-.*%.txt'] = 'requirements',
        ['.*/templates/.*%.ya?ml'] = 'helm',
        ['.*/templates/.*%.tpl'] = 'helm',
        ['.*/playbooks/.*%.ya?ml'] = 'yaml.ansible',
        ['.*/roles/.*/tasks/.*%.ya?ml'] = 'yaml.ansible',
        ['.*/roles/.*/handlers/.*%.ya?ml'] = 'yaml.ansible',
        ['.*/inventory/.*%.ini'] = 'ansible_hosts',
    },
}
