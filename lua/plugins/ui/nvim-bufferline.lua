return {
  'akinsho/nvim-bufferline.lua',
  event = 'VeryLazy',
  opts = {
    options = {
      diagnostics = 'nvim_lsp',
      always_show_bufferline = false,
      diagnostics_indicator = function(_, _, diagnostics_dict)
        local s = ' '
        for e, n in pairs(diagnostics_dict) do
          local sym = e == 'error' and ' ' or (e == 'warning' and ' ' or '')
          s = s .. n .. sym
        end
        return s
      end,
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'Neo-tree',
          highlight = 'Directory',
          text_align = 'left',
        },
      },
    },
  },
}
