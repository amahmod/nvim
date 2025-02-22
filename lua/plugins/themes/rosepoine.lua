return {
    'rose-pine/neovim',
    as = 'rose-pine',
    lazy = false,
    priority = 1000,
    config = function()
        require('rose-pine').setup {}

        -- vim.cmd 'colorscheme rose-pine'
        -- vim.cmd.colorscheme 'rose-pine-main'
        vim.cmd 'colorscheme rose-pine-moon'
        -- vim.cmd("colorscheme rose-pine-dawn")
    end,
}
