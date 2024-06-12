local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

ls.add_snippets('svelte', {
    -- ──────────────────────────────( script )───────────────────────────
    s('s', {
        t { '<script>', '' },
        i(1, ''),
        t { '', '</script>' },
    }),
    -- ─────────────────────────────( script ts )─────────────────────────────
    s('st', {
        t { '<script lang="ts">', '' },
        i(1, ''),
        t { '', '</script>' },
    }),
})
