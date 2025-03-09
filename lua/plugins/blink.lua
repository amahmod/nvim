return {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '*',
    opts = {
        keymap = {
            preset = 'super-tab', -- default, super-tab, enter
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono',
        },
        signature = {
            enabled = true,
        },
        completion = {
            documentation = { auto_show = true, auto_show_delay_ms = 500 },
            list = {
                max_items = 30,
            },
            accept = {
                auto_brackets = {
                    enabled = true,
                    kind_resolution = {
                        enabled = true,
                        blocked_filetypes = {
                            'typescriptreact',
                            'javascriptreact',
                            'vue',
                            'svelte',
                        },
                    },
                },
            },
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
            per_filetype = {
                codecompanion = { 'codecompanion' },
            },
        },
    },
    opts_extend = { 'sources.default' },
}
