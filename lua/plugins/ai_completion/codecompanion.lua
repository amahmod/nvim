return {
    'olimorris/codecompanion.nvim',
    cmd = {
        'CodeCompanion',
        'CodeCompanionActions',
        'CodeCompanionChat',
        'CodeCompanionCmd',
    },
    keys = {
        { '<C-a>', mode = { 'n', 'v' }, '<cmd>CodeCompanionActions<cr>' },
        { '<leader>a', mode = { 'n', 'v' }, '<cmd>CodeCompanionChat Toggle<cr>' },
        { '<leader>A', mode = { 'v' }, '<cmd>CodeCompanionChat Add<cr>' },
        { '<leader>i', mode = { 'n' }, '<cmd>CodeCompanion<cr>' },
        {
            '<leader>i',
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
                },
                diff = {
                    provider = 'mini_diff', -- default|mini_diff
                },
            },
            adapters = {
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
            },
            strategies = {
                chat = {
                    adapter = 'copilot',
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
        require('plugins.ai_completion.codecompanion_fidget_spinner'):init()
    end,
}
