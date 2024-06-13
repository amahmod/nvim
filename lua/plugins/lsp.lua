return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',

            { 'j-hui/fidget.nvim', opts = {} },

            -- Schema information
            'b0o/SchemaStore.nvim',
        },
        config = function()
            local capabilities = nil
            if pcall(require, 'cmp_nvim_lsp') then
                capabilities = require('cmp_nvim_lsp').default_capabilities()
            end

            local lspconfig = require 'lspconfig'

            local servers = {
                html = true,
                bashls = true,
                eslint = true,
                tailwindcss = true,
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
                rust_analyzer = true,
                svelte = true,
                templ = true,
                cssls = true,

                denols = {
                    root_dir = require('lspconfig').util.root_pattern('deno.json', 'deno.jsonc'),
                },
                tsserver = {
                    root_dir = require('lspconfig').util.root_pattern 'package.json',
                    server_capabilities = {
                        documentFormattingProvider = false,
                    },
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
            }

            local servers_to_install = vim.tbl_filter(function(key)
                local t = servers[key]
                if type(t) == 'table' then
                    return not t.manual_install
                else
                    return t
                end
            end, vim.tbl_keys(servers))

            require('mason').setup()
            local ensure_installed = {
                'stylua',
                'lua_ls',
                'prettierd',
                'eslint_d',
            }

            vim.list_extend(ensure_installed, servers_to_install)
            require('mason-tool-installer').setup { ensure_installed = ensure_installed }

            for name, config in pairs(servers) do
                if config == true then
                    config = {}
                end
                config = vim.tbl_deep_extend('force', {}, {
                    capabilities = capabilities,
                }, config)

                lspconfig[name].setup(config)
            end

            local disable_semantic_tokens = {
                lua = true,
            }

            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local bufnr = args.buf
                    local client = assert(
                        vim.lsp.get_client_by_id(args.data.client_id),
                        'must have valid client'
                    )

                    local settings = servers[client.name]
                    if type(settings) ~= 'table' then
                        settings = {}
                    end

                    vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = 0 })
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = 0 })
                    vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, { buffer = 0 })
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0 })

                    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { buffer = 0 })
                    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, { buffer = 0 })

                    local filetype = vim.bo[bufnr].filetype
                    if disable_semantic_tokens[filetype] then
                        client.server_capabilities.semanticTokensProvider = nil
                    end

                    -- Override server capabilities
                    if settings.server_capabilities then
                        for k, v in pairs(settings.server_capabilities) do
                            if v == vim.NIL then
                                ---@diagnostic disable-next-line: cast-local-type
                                v = nil
                            end

                            client.server_capabilities[k] = v
                        end
                    end

                    -- fix: svelte-language-server watcher doesn't work in neovim lspconfig
                    -- https://github.com/sveltejs/language-tools/issues/2008#issuecomment-1838251681
                    if client.name == 'svelte' then
                        vim.api.nvim_create_autocmd('BufWritePost', {
                            pattern = { '*.js', '*.ts' },
                            callback = function(ctx)
                                client.notify('$/onDidChangeTsOrJsFile', { uri = ctx.match })
                            end,
                        })
                    end
                end,
            })
        end,
    },
}
