vim.loader.enable()

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    print 'Installing lazy.nvim plugin manager...'
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        '--branch=stable',
        'https://github.com/folke/lazy.nvim.git',
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
    spec = {
        { import = 'plugins' },
    },
    defaults = { lazy = true },
    performance = {
        rtp = {
            disabled_plugins = {
                'gzip',
                'vimballPlugin',
                'matchit',
                'matchparen',
                '2html_plugin',
                'tarPlugin',
                'netrwPlugin',
                'tutor',
                'zipPlugin',
            },
        },
    },
}

