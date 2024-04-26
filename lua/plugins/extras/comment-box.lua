return {
    'LudoPinelli/comment-box.nvim',
    keys = {
        {
            '<leader>cb',
            function()
                require('comment-box').ccbox(7)
            end,
            desc = 'Comment box',
        },
        {
            '<leader>cl',
            function()
                require('comment-box').lcline(7)
            end,
            desc = 'Comment box',
        },
    },
}
