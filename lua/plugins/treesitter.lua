return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
        cmd = {
            'TSUpdate',
            'TSInstall',
            'TSInstallInfo',
            'TSModuleInfo',
            'TSConfigInfo',
            'TSUpdateSync',
        },
        keys = {
            { 'v', desc = 'Increment selection', mode = 'x' },
            { 'V', desc = 'Shrink selection', mode = 'x' },
        },
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            refactor = {
                highlight_definitions = { enable = true },
                highlight_current_scope = { enable = true },
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<leader>ss',
                    node_incremental = '<leader>si',
                    scope_incremental = '<leader>sc',
                    node_decremental = '<leader>sd',
                },
            },

            -- See: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',
                        ['as'] = {
                            query = '@scope',
                            query_group = 'locals',
                            desc = 'Select language scope',
                        },
                        ['a,'] = '@parameter.outer',
                        ['i,'] = '@parameter.inner',
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ['],'] = '@parameter.inner',
                    },
                    goto_previous_start = {
                        ['[,'] = '@parameter.inner',
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ['>,'] = '@parameter.inner',
                    },
                    swap_previous = {
                        ['<,'] = '@parameter.inner',
                    },
                },
            },

            -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
            ensure_installed = {
                'css',
                'gitcommit',
                'html',
                'query',
                'javascript',
                'jsdoc',
                'lua',
                'make',
                'markdown',
                'markdown_inline',
                'svelte',
                'typescript',
                'vim',
                'vimdoc',
            },
            auto_install = true,
        },
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end,
    },
}
