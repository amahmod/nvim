return {
    'olimorris/codecompanion.nvim',
    cmd = {
        'CodeCompanion',
        'CodeCompanionActions',
        'CodeCompanionChat',
        'CodeCompanionCmd',
    },
    keys = {
        { '<C-S-i>', mode = { 'n', 'v' }, '<cmd>CodeCompanionActions<cr>' },
        { '<C-i>', mode = { 'n', 'v' }, '<cmd>CodeCompanionChat Toggle<cr>' },
        { '<C-i>', mode = { 'v' }, '<cmd>CodeCompanionChat Add<cr>' },
        { '<C-k>', mode = { 'n' }, '<cmd>CodeCompanion<cr>' },
        {
            '<C-k>',
            mode = { 'v', 'x' },
            function()
                local start_pos = vim.api.nvim_buf_get_mark(0, '<')
                local end_pos = vim.api.nvim_buf_get_mark(0, '>')
                vim.api.nvim_command(string.format('%d,%dCodeCompanion', start_pos[1], end_pos[1]))
            end,
        },
    },
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'j-hui/fidget.nvim',
        {
            'MeanderingProgrammer/render-markdown.nvim',
            ft = { 'markdown', 'codecompanion' },
        },
    },
    config = function()
        require('codecompanion').setup {
            opts = {
                log_level = 'DEBUG',
            },
            display = {
                chat = {
                    show_settings = false,
                    auto_scroll = true,
                    start_in_insert_mode = false, -- Open the chat buffer in insert mode?
                },
                diff = {
                    provider = 'default', -- default|mini_diff
                },
            },
            adapters = {
                opts = {
                    show_defaults = false,
                },
                anthropic = function()
                    return require('codecompanion.adapters').extend('anthropic', {
                        env = {
                            api_key = os.getenv 'ANTHROPIC_API_KEY',
                        },
                    })
                end,
                gemini = function()
                    return require('codecompanion.adapters').extend('gemini', {
                        env = {
                            api_key = os.getenv 'GEMINI_API_KEY',
                            model = 'gemini-2.0-flash',
                        },
                    })
                end,
                copilot = function()
                    return require('codecompanion.adapters').extend('copilot', {
                        schema = {
                            model = {
                                default = 'claude-3.7-sonnet',
                            },
                        },
                    })
                end,
            },
            strategies = {
                chat = {
                    adapter = 'copilot',
                    roles = {
                        ---The header name for the LLM's messages
                        ---@type string|fun(adapter: CodeCompanion.Adapter): string
                        llm = function(adapter)
                            return 'CodeCompanion (' .. adapter.formatted_name .. ')'
                        end,

                        ---The header name for your messages
                        ---@type string
                        user = 'amahmod',
                    },
                },
                agent = {
                    adapter = 'copilot',
                },
                inline = {
                    adapter = 'copilot',
                    keymaps = {
                        accept_change = {
                            modes = { n = 'ga' },
                            description = 'Accept the suggested change',
                        },
                        reject_change = {
                            modes = { n = 'gr' },
                            description = 'Reject the suggested change',
                        },
                    },
                },
            },
        }
        require 'plugins.ai_completion.codecompanion_fidget_spinner'
    end,
}
