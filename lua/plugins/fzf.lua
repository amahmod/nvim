return {
    'ibhagwan/fzf-lua',
    -- optional for icon support
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        -- calling `setup` is optional for customization
        require('fzf-lua').setup {}
    end,
    keys = {
        -- files
        { '<C-p>', ':FzfLua files<CR>', desc = 'Find files' },
        { '<leader>ff', ':FzfLua files<CR>', desc = '[f]ind [f]iles' },
        { '<leader>fr', ':FzfLua resume<CR>', desc = '[f]zf [r]esume' },
        { '<leader>fo', ':FzfLua oldfiles<CR>', desc = '[f]ind [o]ld files' },

        -- lines
        { '<leader>fl', ':FzfLua blines<CR>', desc = '[f]ind  current buffer [l]ines' },
        { '<leader>fL', ':FzfLua lines<CR>', desc = '[f]ind [l]ines' },

        -- search/grep
        { '<leader>lg', ':FzfLua grep_visual<CR>', desc = '[l]ive [g]rep', mode = { 'x', 'v' } },
        { '<leader>lg', ':FzfLua live_grep_native<CR>', desc = '[l]ive [g]rep', mode = 'n' },
        { '<leader>gr', ':FzfLua live_grep_resume<CR>', desc = 'Grep resume' },

        -- LSP
        { '<leader>lr', ':FzfLua lsp_references<CR>', desc = '[l]sp [r]eferences' },
        { '<leader>li', ':FzfLua lsp_implementations<CR>', desc = '[l]sp [i]mplementations' },
        { '<leader>ls', ':FzfLua lsp_document_symbols<CR>', desc = '[l]sp document [s]ymbols' },
        { '<leader>lS', ':FzfLua lsp_workspace_symbols<CR>', desc = '[l]sp workspace [S]ymbols' },
        { '<leader>ic', ':FzfLua lsp_incoming_calls<CR>', desc = 'Lsp [i]ncoming [c]alls' },
        { '<leader>oc', ':FzfLua lsp_outgoing_calls<CR>', desc = 'Lsp [o]outgoing [c]alls' },
        { '<leader>ca', ':FzfLua lsp_code_actions<CR>', desc = 'Lsp [c]ode [a]ctions' },

        -- stylua: ignore start
        { '<leader>ld', ':FzfLua lsp_document_diagnostics<CR>', desc = '[l]sp document [d]iagnostics', },
        { '<leader>lD', ':FzfLua lsp_workspace_diagnostics<CR>', desc = '[l]sp workspace [D]iagnostics', },
        -- stylua: ignore end

        -- misc
        { '<leader><leader>', ':FzfLua builtin<CR>', desc = 'FzfLua builtin commands' },
        { '<leader>;', ':FzfLua commands<CR>', desc = 'Commands' },
        { '<leader>:', ':FzfLua command_history<CR>', desc = 'Comamnd hisotry' },
        { '<leader>/', ':FzfLua search_history<CR>', desc = 'Search history' },
    },
}
