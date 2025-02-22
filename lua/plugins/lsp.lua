local function create_diagnostic_goto(opts)
    local go = opts.next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    local severity = opts.severity and vim.diagnostic.severity[opts.severity] or nil
    return function()
        go { severity = severity }
    end
end

return {
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            { 'j-hui/fidget.nvim', opts = {} },
            'b0o/SchemaStore.nvim',
            'saghen/blink.cmp',
        },
        config = function()
            ---@type table<string, boolean>
            local disable_semantic_tokens = {
                lua = true,
            }

            ---@param client table
            ---@param settings ServerConfig
            local function apply_server_capabilities(client, settings)
                if not settings.server_capabilities then
                    return
                end

                for capability, value in pairs(settings.server_capabilities) do
                    if value == vim.NIL then
                        value = nil
                    end
                    client.server_capabilities[capability] = value
                end
            end

            ---@param bufnr number
            ---@param client table
            local function setup_keymaps(bufnr, client)
                local opts = { buffer = bufnr }

                -- INFO: snack.nvim has these keymaps
                -- Navigation
                -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                -- vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, opts)
                -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

                -- Actions
                vim.keymap.set('n', '<leader>hd', vim.diagnostic.open_float, opts)
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set({ 'n', 'x' }, '<leader>ca', function()
                    vim.lsp.buf.code_action {
                        context = { only = { 'source', 'refactor', 'quickfix' } },
                    }
                end, opts)

                -- Diagnostics navigation
                vim.keymap.set('n', '[d', create_diagnostic_goto { next = false }, opts)
                vim.keymap.set('n', ']d', create_diagnostic_goto { next = true }, opts)
                vim.keymap.set(
                    'n',
                    '[e',
                    create_diagnostic_goto { next = false, severity = 'ERROR' },
                    opts
                )
                vim.keymap.set(
                    'n',
                    ']e',
                    create_diagnostic_goto { next = true, severity = 'ERROR' },
                    opts
                )
                vim.keymap.set(
                    'n',
                    '[w',
                    create_diagnostic_goto { next = false, severity = 'WARNING' },
                    opts
                )
                vim.keymap.set(
                    'n',
                    ']w',
                    create_diagnostic_goto { next = true, severity = 'WARNING' },
                    opts
                )

                -- TypeScript and Svelte specific keymaps
                if client.name == 'typescript-tools' or client.name == 'svelte' then
                    vim.keymap.set('n', '<leader>to', '<cmd>TSToolsOrganizeImports<cr>', opts)
                    vim.keymap.set('n', '<leader>ta', '<cmd>TSToolsAddMissingImports<cr>', opts)
                    vim.keymap.set('n', '<leader>tr', '<cmd>TSToolsRemoveUnusedImports<cr>', opts)
                    vim.keymap.set('n', '<leader>tf', '<cmd>TSToolsFixAll<cr>', opts)
                    vim.keymap.set('n', '<leader>tR', '<cmd>TSToolsRenameFile<cr>', opts)
                end
            end

            ---@param client table
            local function setup_svelte_file_watcher(client)
                if client.name ~= 'svelte' then
                    return
                end

                vim.api.nvim_create_autocmd('BufWritePost', {
                    pattern = { '*.js', '*.ts' },
                    callback = function(ctx)
                        client.notify('$/onDidChangeTsOrJsFile', { uri = ctx.match })
                    end,
                })
            end

            -- Configure diagnostics
            vim.diagnostic.config {
                virtual_text = {
                    source = 'always',
                },
                float = {
                    source = 'always',
                },
            }

            -- Server configurations
            ---@type table<string, ServerConfig>
            local servers = {
                gopls = {
                    settings = {
                        gopls = {
                            hints = {
                                assignVariableTypes = true,
                                compositeLiteralFields = true,
                                compositeLiteralTypes = true,
                                constantValues = true,
                                functionTypeParameters = true,
                                parameterNames = true,
                                rangeVariableTypes = true,
                            },
                        },
                    },
                },
                pyright = {
                    settings = {
                        python = {
                            analysis = {
                                autoSearchPaths = true,
                                diagnosticMode = 'openFilesOnly',
                                useLibraryCodeForTypes = true,
                            },
                        },
                    },
                },
                lua_ls = {
                    server_capabilities = {
                        semanticTokensProvider = vim.NIL,
                    },
                    settings = {
                        Lua = {
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
                denols = {
                    root_dir = require('lspconfig.util').root_pattern('deno.json', 'deno.jsonc'),
                },
                jsonls = {
                    settings = {
                        json = {
                            schemas = require('schemastore').json.schemas(),
                            validate = { enable = true },
                        },
                    },
                },
                yamlls = {
                    settings = {
                        yaml = {
                            schemaStore = {
                                enable = false,
                                url = '',
                            },
                            schemas = require('schemastore').yaml.schemas(),
                        },
                    },
                },
                vtsls = {},
            }

            -- Setup Mason
            require('mason').setup {
                ui = {
                    icons = {
                        package_installed = '✓',
                        package_pending = '➜',
                        package_uninstalled = '✗',
                    },
                },
            }

            -- Setup mason-lspconfig
            require('mason-lspconfig').setup {
                -- Automatically install LSP servers
                ensure_installed = {
                    'lua_ls',
                    'html',
                    'cssls',
                    'tailwindcss',
                    'jsonls',
                    'yamlls',
                    'eslint',
                    'bashls',
                    'rust_analyzer',
                    'pyright',
                    'gopls',
                    'svelte',
                    'templ',
                    'vtsls',
                },
                -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed
                automatic_installation = true,
            }

            -- Setup mason-tool-installer
            require('mason-tool-installer').setup {
                ensure_installed = {
                    'stylua',
                    'prettierd',
                    'eslint_d',
                    'black',
                    'ruff',
                },
                auto_update = true,
                run_on_start = true,
            }

            local capabilities = require('blink.cmp').get_lsp_capabilities()

            -- Setup handlers
            require('mason-lspconfig').setup_handlers {
                -- Default handler
                function(server_name)
                    -- Skip tsserver as we're using typescript-tools instead
                    -- if server_name == 'tsserver' then
                    --     return
                    -- end

                    local server_config = servers[server_name] or {}

                    ---@type ServerConfig
                    local config = vim.tbl_deep_extend('force', {
                        capabilities = capabilities,
                    }, server_config)

                    require('lspconfig')[server_name].setup(config)
                end,
            }

            -- Setup LSP handlers
            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)

                    if not client then
                        vim.notify('Failed to get LSP client', vim.log.levels.ERROR)
                        return
                    end

                    local settings = servers[client.name] or {}

                    -- Setup buffer-local options
                    vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- Setup keymaps
                    setup_keymaps(bufnr, client)

                    -- Handle semantic tokens
                    local filetype = vim.bo[bufnr].filetype
                    if disable_semantic_tokens[filetype] then
                        client.server_capabilities.semanticTokensProvider = nil
                    end

                    -- Apply server-specific capabilities
                    apply_server_capabilities(client, settings)

                    -- Setup Svelte file watcher
                    setup_svelte_file_watcher(client)
                end,
            })
        end,
    },
}
