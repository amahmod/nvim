return {
    'tpope/vim-fugitive',
    lazy = true,
    cmd = {
        'G',
        'Git',
        'Gdiff',
        'Gclog',
        'Ggrep',
        'Gread',
        'Gwrite',
        'GDelete',
        'GBrowser',
        'Gdiffsplit',
        'Gvdiffsplit',
        'Gfetch',
        'Gfetch',
    },
    keys = {
        { '<leader>gg', '<cmd>Git<cr>', desc = 'Git status' },
    },
}
