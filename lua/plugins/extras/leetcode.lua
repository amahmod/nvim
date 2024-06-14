local leet_arg = "leetcode.nvim"

return {
    'kawre/leetcode.nvim',
    build = ':TSUpdate html',
    lazy = leet_arg ~= vim.fn.argv()[1],
    dependencies = {
        'nvim-telescope/telescope.nvim',
        'nvim-lua/plenary.nvim', -- required by telescope
        'MunifTanjim/nui.nvim',

        -- optional
        'nvim-treesitter/nvim-treesitter',
        'rcarriga/nvim-notify',
        'nvim-tree/nvim-web-devicons',
    },
    opts = {
        -- configuration goes here
        arg = leet_arg,
        lang = 'typescript',
    },
}
