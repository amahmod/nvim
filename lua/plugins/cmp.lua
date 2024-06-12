return {
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            { 'L3MON4D3/LuaSnip', build = 'make install_jsregexp' },
        },
        config = function()
            local icons = {
                Array = '',
                Boolean = '',
                Class = '',
                Color = '',
                Constant = '',
                Constructor = '',
                Enum = '',
                EnumMember = '',
                Event = '',
                Field = '',
                File = '',
                Folder = '',
                Function = '',
                Interface = '',
                Key = '',
                Keyword = '',
                Method = '',
                Module = '',
                Namespace = '',
                Null = 'ﳠ',
                Number = '',
                Object = '',
                Operator = '',
                Package = '',
                Property = '',
                Reference = '',
                Snippet = '',
                String = '',
                Struct = '',
                Text = '',
                TypeParameter = '',
                Unit = '',
                Value = '',
                Variable = '',
            }
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'

            cmp.setup {
                formatting = {
                    fields = { 'kind', 'abbr', 'menu' },
                    format = function(entry, item)
                        local max_width = 0
                        local source_names = {
                            nvim_lsp = '(LSP)',
                            path = '(Path)',
                            luasnip = '(Snippet)',
                            buffer = '(Buffer)',
                        }
                        local duplicates = {
                            buffer = 1,
                            path = 1,
                            nvim_lsp = 0,
                            luasnip = 1,
                        }
                        local duplicates_default = 0
                        if max_width ~= 0 and #item.abbr > max_width then
                            item.abbr = string.sub(item.abbr, 1, max_width - 1) .. '...'
                        end
                        item.kind = icons[item.kind]
                        item.menu = source_names[entry.source.name]
                        item.dup = duplicates[entry.source.name] or duplicates_default
                        return item
                    end,
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = {
                    ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
                    ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
                    ['<CR>'] = cmp.mapping(
                        cmp.mapping.confirm {
                            behavior = cmp.ConfirmBehavior.Insert,
                            select = false,
                        },
                        { 'i', 'c' }
                    ),
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'buffer' },
                    { name = 'path' },
                },
            }

            -- Setup up vim-dadbod
            cmp.setup.filetype({ 'sql' }, {
                sources = {
                    { name = 'vim-dadbod-completion' },
                    { name = 'buffer' },
                },
            })

            local ls = require 'luasnip'
            ls.config.set_config {
                history = false,
                updateevents = 'TextChanged,TextChangedI',
            }
            ls.filetype_extend('typescript', { 'javascript' })
            ls.filetype_extend('svelte', { 'javascript' })

            for _, ft_path in ipairs(vim.api.nvim_get_runtime_file('lua/snippets/*.lua', true)) do
                loadfile(ft_path)()
            end

            vim.keymap.set({ 'i', 's' }, '<c-k>', function()
                if ls.expand_or_jumpable() then
                    ls.expand_or_jump()
                end
            end, { silent = true })

            vim.keymap.set({ 'i', 's' }, '<c-j>', function()
                if ls.jumpable(-1) then
                    ls.jump(-1)
                end
            end, { silent = true })
        end,
    },
}
