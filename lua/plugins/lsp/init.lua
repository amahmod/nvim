return {
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
        },
        opts = {
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = {
                    spacing = 4,
                    source = 'always',
                    prefix = '●',
                },
                severity_sort = true,
            },
            inlay_hints = {
                enabled = false,
            },
            capabilities = {
                textDocument = {
                    foldingRange = {
                        dynamicRegistration = false,
                        lineFoldingOnly = true,
                    },
                },
            },
            setup = {},
            servers = require 'plugins.lsp.servers',
        },
        config = function(_, opts)
            local lsp_utils = require 'plugins.lsp.utils'

            local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint

            lsp_utils.on_attach(function(client, bufnr)
                require('plugins.lsp.keymaps').on_attach(client, bufnr)
                if client.supports_method 'textDocument/inlayHint' and opts.inlay_hints.enabled then
                    inlay_hint(bufnr, true)
                end
            end)

            local has_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
            local capabilities = vim.tbl_deep_extend(
                'force',
                {},
                vim.lsp.protocol.make_client_capabilities(),
                has_cmp and cmp_nvim_lsp.default_capabilities() or {},
                opts.capabilities or {}
            )

            require('mason-lspconfig').setup {
                ensure_installed = vim.tbl_keys(opts.servers),
                handlers = {
                    function(server)
                        local server_opts = vim.tbl_deep_extend('force', {
                            capabilities = vim.deepcopy(capabilities),
                        }, opts.servers[server] or {})

                        server_opts.capabilities = capabilities
                        require('lspconfig')[server].setup(server_opts)
                    end,
                },
            }
        end,
    },
    {

        'williamboman/mason.nvim',
        cmd = 'Mason',
        build = ':MasonUpdate',
        opts = {
            ensure_installed = {
                'prettierd',
                'eslint_d',
                'stylua',
            },
        },
        ---@param opts MasonSettings | {ensure_installed: string[]}
        config = function(_, opts)
            require('mason').setup(opts)
            local mr = require 'mason-registry'
            mr:on('package:install:success', function()
                vim.defer_fn(function()
                    -- trigger FileType event to possibly load this newly installed LSP server
                    require('lazy.core.handler.event').trigger {
                        event = 'FileType',
                        buf = vim.api.nvim_get_current_buf(),
                    }
                end, 100)
            end)
            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end
            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },
    {
        'pmizio/typescript-tools.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
        opts = {},
    },
}
