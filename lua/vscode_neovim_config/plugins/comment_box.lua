return {
    'LudoPinelli/comment-box.nvim',
    keys = {
        {
            '<leader>cb',
            function()
                require('comment-box').ccbox(7)
            end,
            desc = 'Comment box',
            mode = { 'n', 'v' },
        },
        {
            '<leader>cl',
            function()
                require('comment-box').lcline(7)
            end,
            desc = 'Comment box',
            mode = { 'n', 'v' },
        },
    },
}
