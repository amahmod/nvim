local user_settings = require 'config.settings'

return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
        {
            '<leader>lf',
            function()
                require('conform').format { async = true, lsp_fallback = true }
            end,
            mode = { 'n', 'v' },
            desc = 'Format buffer',
        },
    },
    config = function()
        if user_settings.format_on_save then
            vim.api.nvim_create_autocmd('BufWritePre', {
                pattern = '*',
                callback = function(args)
                    require('conform').format { bufnr = args.buf }
                end,
            })
        end

        local prettier = { 'prettierd', 'prettier' }
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        require('conform').setup {
            formatters_by_ft = {
                css = { prettier },
                html = { prettier },
                javascript = { prettier },
                json = { prettier },
                lua = { 'stylua' },
                markdown = { prettier },
                svelte = { prettier },
                typescript = { prettier },
                sql = { 'pg_format' },
                sh = { 'shfmt' },
            },
        }
    end,
}
