return {
    html = {},
    emmet_ls = {},
    rust_analyzer = {
        settings = {
            diagnostics = {
                enable = true,
            },
        },
    },
    bashls = {},
    -- denols = {}, -- FIX: conflict with tsserver/typescript tools
    -- tsserver = {}, -- Replaced by 'pmizio/typescript-tools.nvim'
    yamlls = {},
    dockerls = {},
    gopls = {
        settings = {
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
        },
    },
    sqlls = {
        cmd = { 'sql-language-server', 'up', '--method', 'stdio' },
        filetypes = { 'sql', 'mysql' },
        root_dir = function()
            return vim.loop.cwd()
        end,
    },
    svelte = {},
    volar = {},
    eslint = {},
    tailwindcss = {},
    graphql = {},
    marksman = {},
    cssls = {},
    jsonls = {},
    lua_ls = {
        settings = {
            Lua = {
                hint = {
                    enable = true,
                    showParameterName = true,
                },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        [vim.fn.expand '$VIMRUNTIME/lua'] = true,
                        [vim.fn.expand '$VIMRUNTIME/lua/vim/lsp'] = true,
                    },
                },
                telemetry = { enable = false },
                completion = {
                    callSnippet = 'Replace',
                },
                diagnostics = {
                    globals = {
                        'vim',
                        'use',
                        'describe',
                        'it',
                        'assert',
                        'before_each',
                        'after_each',
                    },
                },
            },
        },
    },
}
