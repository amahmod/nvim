return {
    'stevearc/oil.nvim',
    lazy = true,
    keys = {
        { '<leader>e', '<cmd>Oil<cr>', desc = 'Open Oil' },
    },
    opts = {
        default_file_explorer = true,
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        lsp_file_methods = {
            timeout_ms = 1000,
            autosave_changes = 'unmodified',
        },
        keymaps = {
            ['l'] = 'actions.select',
            ['h'] = 'actions.parent',
        },
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
}
