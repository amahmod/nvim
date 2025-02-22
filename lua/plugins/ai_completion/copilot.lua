return {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
        require('copilot').setup {
            panel = {
                enabled = false,
            },
            suggestion = {
                enabled = true,
                auto_trigger = true,
                hide_during_completion = true,
                debounce = 75,
                keymap = {
                    accept = '<Tab>',
                    accept_word = false,
                    accept_line = false,
                },
            },
            filetypes = {
                yaml = false,
                markdown = true,
                help = false,
                gitcommit = true,
                gitrebase = false,
                hgcommit = false,
                svn = false,
                cvs = false,
                ['.'] = false,
            },
            copilot_node_command = 'node', -- Node.js version must be > 18.x
            server_opts_overrides = {},
        }
    end,
}
