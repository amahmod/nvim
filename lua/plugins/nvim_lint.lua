---@type table<string, string[]>
local linters_by_ft = {
    javascript = { 'eslint_d' },
    typescript = { 'eslint_d' },
    javascriptreact = { 'eslint_d' },
    typescriptreact = { 'eslint_d' },
    svelte = { 'eslint_d' },
    vue = { 'eslint_d' },
    python = { 'ruff', 'pylint', 'mypy' },
    markdown = { 'vale', 'markdownlint' },
    css = { 'stylelint' },
    scss = { 'stylelint' },
    less = { 'stylelint' },
    json = { 'jsonlint' },
    yaml = { 'yamllint' },
    lua = { 'luacheck' }, -- 'selene'
    sh = { 'shellcheck' },
    bash = { 'shellcheck' },
    zsh = { 'shellcheck' },
    dockerfile = { 'hadolint' },
}

return {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'williamboman/mason.nvim',
        'rshkarin/mason-nvim-lint',
    },
    config = function()
        local lint = require 'lint'

        -- Configure linters
        lint.linters_by_ft = linters_by_ft

        -- Configure specific linter options
        lint.linters.eslint_d = {
            cmd = 'eslint_d',
            args = {
                '--no-warn-ignored',
                '--format',
                'json',
                '--stdin',
                '--stdin-filename',
                function()
                    return vim.api.nvim_buf_get_name(0)
                end,
            },
            stdin = true,
            stream = false,
            ignore_exitcode = true,
            env = nil,
        }

        lint.linters.luacheck = {
            cmd = 'luacheck',
            args = {
                '--formatter',
                'plain',
                '--codes',
                '--ranges',
                '--filename',
                function()
                    return vim.api.nvim_buf_get_name(0)
                end,
                '-',
            },
            stdin = true,
            stream = false,
            ignore_exitcode = true,
        }

        lint.linters.pylint = {
            cmd = 'pylint',
            args = {
                '--output-format=json',
                '--score=no',
                function()
                    return vim.api.nvim_buf_get_name(0)
                end,
            },
            stdin = false,
            stream = false,
            ignore_exitcode = true,
        }

        -- Setup Mason
        require('mason').setup {
            ui = {
                icons = {
                    package_installed = '✓',
                    package_pending = '➜',
                    package_uninstalled = '✗',
                },
            },
        }

        require('mason-nvim-lint').setup {
            ensure_installed = {
                'vale',
                'eslint_d',
                'stylelint',
                'jsonlint',
                'luacheck',
                'ruff',
            },
        }

        -- Create lint autocommands
        local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

        -- Function to check if we should lint
        ---@param bufnr number
        ---@return boolean
        local function should_lint(bufnr)
            -- Don't lint if buffer is not loaded
            if not vim.api.nvim_buf_is_loaded(bufnr) then
                return false
            end

            -- Don't lint large files
            if vim.fn.wordcount().bytes > 1024 * 1024 then -- Skip files larger than 1MB
                return false
            end

            -- Don't lint certain filetypes
            local excluded_filetypes = {
                'help',
                -- 'markdown',
                'text',
                'gitcommit',
            }
            local ft = vim.bo[bufnr].filetype
            return not vim.tbl_contains(excluded_filetypes, ft)
        end

        -- Function to debounce linting
        local timer = vim.loop.new_timer()
        ---@param bufnr number
        local function debounced_lint(bufnr)
            if timer:is_active() then
                timer:stop()
            end
            timer:start(
                1000,
                0,
                vim.schedule_wrap(function()
                    if should_lint(bufnr) then
                        lint.try_lint(nil, { ignore_errors = true })
                    end
                end)
            )
        end

        -- Setup autocommands for linting
        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
            group = lint_augroup,
            callback = function(args)
                debounced_lint(args.buf)
            end,
        })
    end,
}
