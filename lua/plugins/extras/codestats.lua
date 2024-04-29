return {
    'YannickFricke/codestats.nvim',
    event = 'VeryLazy',
    config = function()
        require('codestats-nvim').setup {
            token = 'SFMyNTY.WVcxaGFHMXZaQT09IyNNakkzTlRFPQ.CKcSXFxSVeE3BLUsy1qPlTS6Vo1UaaesBkEIHrA9ANI',
        }
    end,
    dependencies = { { 'nvim-lua/plenary.nvim' } },
}
