return {
  { 'nvim-neotest/neotest-plenary' },
  {
    'nvim-neotest/neotest',
    opts = {
      adapters = { 'neotest-plenary' },
      -- Example for loading neotest-go with a custom config
      -- adapters = {
      --   ["neotest-go"] = {
      --     args = { "-tags=integration" },
      --   },
      -- },
      output = { open_on_run = true },
      quickfix = {
        open = function()
          if require('fearphage.helpers').has('trouble.nvim') then
            vim.cmd('Trouble quickfix')
          else
            vim.cmd('copen')
          end
        end,
      },
      status = { virtual_text = true },
    },
  },
}
