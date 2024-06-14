vim.g.mapleader = ' '

require 'keymaps'
require 'options'

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
        { import = 'plugins/extras' },
    },
    change_detection = {
        notify = false,
    },
}
