return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    opts = {
        completions = {
            blink = { enabled = true },
        },
    },
    ft = { 'markdown', 'Avante', 'codecompanion' },
}
