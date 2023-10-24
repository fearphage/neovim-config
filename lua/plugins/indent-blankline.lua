return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  opts = {
    indent = {
      char = '',
    },
    scope = {
      show_exact_scope = true,
    },
    whitespace = {
      highlight = {
        'Function',
        'Label',
        'Whitespace',
        'NonText',
      },
    },
    -- space_char_highlight_list = {
    --   'IndentBlanklineIndent1',
    --   'IndentBlanklineIndent2',
    -- },
  },
}
