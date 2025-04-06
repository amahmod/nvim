return {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
        require('mini.ai').setup()
        require('mini.align').setup()
        require('mini.pairs').setup()
        require('mini.diff').setup()
    end,
}
