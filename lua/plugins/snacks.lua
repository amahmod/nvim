return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        explorer = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        bufdelete = { enabled = true },
        dim = { enabled = true },
        git = { enabled = true },
        images = { enabled = true },
        layout = { enabled = true },
        rename = { enabled = true },
        zen = { enabled = true },
        notifier = {
            enabled = true,
            timeout = 3000,
        },
        picker = {
            enabled = true,
            sources = {
                explorer = {
                    layout = {
                        layout = { position = 'right' },
                    },
                },
            },
        },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        styles = {
            notification = {
                -- wo = { wrap = true } -- Wrap notifications
            },
            zen = {
                backdrop = { transparent = true, blend = 0 },
            },
        },
    },
    keys = {
        -- stylua: ignore start
        -- Top Pickers & Explorer
        { "<C-p>", function() Snacks.picker.smart() end, desc = "Smart file finder" },
        { "<leader>,", function() Snacks.picker.buffers() end, desc = "Browse buffers" },
        { "<leader>/", function() Snacks.picker.grep() end, desc = "Search in files" },
        { "<leader>n", function() Snacks.picker.notifications() end, desc = "View notifications" },
        { "<leader>e", function() Snacks.explorer() end, desc = "Open file explorer" },
        { "<leader>;", function() Snacks.picker.command_history() end, desc = "Browse command history" },
        { "<leader>:", function() Snacks.picker.commands() end, desc = "Browse available commands" },
        -- find
        { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Find buffers" },
        { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find config files" },
        { "<leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
        { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find git tracked files" },
        { "<leader>fp", function() Snacks.picker.projects() end, desc = "Browse projects" },
        { "<leader>fr", function() Snacks.picker.recent() end, desc = "Browse recent files" },
        -- git
        { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Browse git branches" },
        { "<leader>gl", function() Snacks.picker.git_log() end, desc = "View git commit log" },
        { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "View git log for current line" },
        { "<leader>gs", function() Snacks.picker.git_status() end, desc = "View git status" },
        { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Browse git stash" },
        { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "View git diff hunks" },
        { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "View git history for file" },
        -- Grep
        { "<leader>sb", function() Snacks.picker.lines() end, desc = "Search in buffer" },
        { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Search in all buffers" },
        { "<leader>sg", function() Snacks.picker.grep() end, desc = "Search in files" },
        { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Search current word/selection", mode = { "n", "x" } },
        -- search
        { '<leader>s"', function() Snacks.picker.registers() end, desc = "Browse registers" },
        { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Browse search history" },
        { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Browse autocmds" },
        { "<leader>sb", function() Snacks.picker.lines() end, desc = "Search in buffer" },
        { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Browse all diagnostics" },
        { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Browse buffer diagnostics" },
        { "<leader>sh", function() Snacks.picker.help() end, desc = "Search help pages" },
        { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Browse highlight groups" },
        { "<leader>si", function() Snacks.picker.icons() end, desc = "Browse icons" },
        { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Browse jump list" },
        { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Browse keymaps" },
        { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Browse location list" },
        { "<leader>sm", function() Snacks.picker.marks() end, desc = "Browse marks" },
        { "<leader>sM", function() Snacks.picker.man() end, desc = "Search man pages" },
        { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search plugins" },
        { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Browse quickfix list" },
        { "<leader>sr", function() Snacks.picker.resume() end, desc = "Resume last picker" },
        { "<leader>su", function() Snacks.picker.undo() end, desc = "Browse undo history" },
        { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Browse colorschemes" },
        -- LSP
        { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Go to definition" },
        { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Go to declaration" },
        { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "Find references" },
        { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Go to implementation" },
        { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Go to type definition" },
        { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "Browse document symbols" },
        { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Browse workspace symbols" },
        -- Other
        { "<leader>z",  function() Snacks.zen() end, desc = "Toggle zen mode" },
        { "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle zoom" },
        { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle scratch buffer" },
        { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select scratch buffer" },
        { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Show notification history" },
        { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete buffer" },
        { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename current file" },
        { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Open in git browser", mode = { "n", "v" } },
        { "<leader>gg", function() Snacks.lazygit() end, desc = "Open lazygit" },
        { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss notifications" },
        { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle terminal" },
        { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
        { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Jump to next reference", mode = { "n", "t" } },
        { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Jump to previous reference", mode = { "n", "t" } },
        {
        "<leader>N",
        desc = "Open Neovim news",
        function()
            Snacks.win({
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
                spell = false,
                wrap = false,
                signcolumn = "yes",
                statuscolumn = " ",
                conceallevel = 3,
            },
            })
        end,
        }
,
        -- stylua: ignore end
    },
    init = function()
        vim.api.nvim_create_autocmd('User', {
            pattern = 'VeryLazy',
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd -- Override print to use snacks for `:=` command

                -- Create some toggle mappings
                Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
                Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
                Snacks.toggle
                    .option('relativenumber', { name = 'Relative Number' })
                    :map '<leader>uL'
                Snacks.toggle.diagnostics():map '<leader>ud'
                Snacks.toggle.line_number():map '<leader>ul'
                Snacks.toggle
                    .option(
                        'conceallevel',
                        { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }
                    )
                    :map '<leader>uc'
                Snacks.toggle.treesitter():map '<leader>uT'
                Snacks.toggle
                    .option('background', { off = 'light', on = 'dark', name = 'Dark Background' })
                    :map '<leader>ub'
                Snacks.toggle.inlay_hints():map '<leader>uh'
                Snacks.toggle.indent():map '<leader>ug'
                Snacks.toggle.dim():map '<leader>uD'
            end,
        })
    end,
}
