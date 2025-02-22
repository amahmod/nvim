---@type boolean
local auto_format_on_save = true

---@type table<string, string[]|table>
local prettier_config = {
    'prettierd',
    'prettier', -- fallback
    stop_after_first = true,
}

return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
        {
            '<leader>lf',
            function()
                require('conform').format {
                    async = true,
                    lsp_fallback = true,
                    timeout_ms = 500,
                }
            end,
            mode = { 'n', 'v' },
            desc = 'Format buffer',
        },
    },
    opts = {
        -- Define formatters
        formatters_by_ft = {
            lua = { 'stylua' },
            python = { 'isort', 'black' },
            javascript = prettier_config,
            typescript = prettier_config,
            javascriptreact = prettier_config,
            typescriptreact = prettier_config,
            svelte = prettier_config,
            css = prettier_config,
            html = prettier_config,
            json = prettier_config,
            jsonc = prettier_config,
            yaml = prettier_config,
            markdown = prettier_config,
            graphql = prettier_config,
            handlebars = prettier_config,
            sql = { 'pg_format' },
            python = { 'ruff_format', 'black' },
            go = { 'gofmt', 'goimports' },
            rust = { 'rustfmt' },
            -- Shell scripts
            sh = { 'shfmt' },
            zsh = { 'shfmt' },
            bash = { 'shfmt' },
        },

        -- Customize formatters
        formatters = {
            shfmt = {
                prepend_args = { '-i', '2', '-ci' },
            },
            prettier = {
                -- Use local prettier if available
                prefer_local = 'node_modules/.bin',
            },
            black = {
                prepend_args = { '--fast', '--line-length=88' },
            },
        },

        -- Format options
        format_on_save = auto_format_on_save and {
            timeout_ms = 500,
            lsp_fallback = true,
            async = false,
        } or nil,

        -- Customize format command
        format_after_save = auto_format_on_save and {
            lsp_fallback = true,
        } or nil,

        -- Set formatexpr
        init = function()
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
    },
}
