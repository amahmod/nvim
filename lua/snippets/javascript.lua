local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

ls.add_snippets('javascript', {
    -- ──────────────────────────────( console.log )──────────────────────────────
    s('cl', {
        t 'console.log(',
        i(1, 'message'),
        t ');',
    }),
    -- ───────────────────────────( if )────────────────────────
    s('if', {
        t 'if (',
        i(1, 'condition'),
        t { ') {', '  ' },
        i(2, '// body'),
        t { '', '}' },
    }),
    -- ──────────────────────────────( if else )──────────────────────────────
    s('ifelse', {
        t 'if (',
        i(1, 'condition'),
        t { ') {', '  ' },
        i(2, '// if body'),
        t { '', '} else {', '  ' },
        i(3, '// else body'),
        t { '', '}' },
    }),
    -- ───────────────────────────────( class )───────────────────────────────
    s('class', {
        t 'class ',
        i(1, 'ClassName'),
        t ' {',
        t { '', '  constructor(' },
        i(2, 'parameters: type'),
        t { ') {', '    ' },
        i(3, '// constructor body'),
        t { '', '  }', '  ' },
        i(4, 'method(): returnType {'),
        t { '', '    ' },
        i(5, '// method body'),
        t { '', '  }', '}' },
    }),
})
