return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/nvim-treesitter-context',
            'windwp/nvim-ts-autotag',
        },
        build = ':TSUpdate',
        lazy = false,
        keys = {
            { 'v', desc = 'Increment selection', mode = 'x' },
            { 'V', desc = 'Shrink selection', mode = 'x' },
        },
        opts = {
            highlight = { 
                enable = true,
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
            },
            indent = { enable = true },
            autotag = { enable = true },
            context_commentstring = { enable = true, enable_autocmd = false },
            refactor = {
                highlight_definitions = { enable = true },
                highlight_current_scope = { enable = true },
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<C-space>',
                    node_incremental = '<C-space>',
                    scope_incremental = '<C-s>',
                    node_decremental = '<M-space>',
                },
            },

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

            ensure_installed = {
                'tsx',
                'json',
                'json5',
                'jsonc',
                'graphql',
                'regex',
                'prisma',
                'rust',
                'toml',
                'sql',
                'dockerfile',
                'yaml',
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
            
            sync_install = {
                "lua",
                "vim",
                "vimdoc",
                "query",
            },
        },
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)

            
            require('treesitter-context').setup {
                enable = true,
                max_lines = 3,
                line_numbers = true,
                multiline_threshold = 20,
                trim_scope = 'outer',
                mode = 'cursor',
                separator = '─',
                zindex = 20,
                patterns = {
                    default = {
                        'class',
                        'function',
                        'method',
                        'for',
                        'while',
                        'if',
                        'switch',
                        'case',
                    },
                    rust = {
                        'impl_item',
                        'struct',
                        'enum',
                    },
                    typescript = {
                        'interface',
                        'type_alias',
                        'enum_declaration',
                    },
                },
            }

            vim.opt.foldmethod = 'expr'
            vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
            vim.opt.foldenable = false
            vim.opt.foldlevel = 99
        end,
    },
}
