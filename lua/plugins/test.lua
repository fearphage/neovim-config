return {
  -- { 'nvim-neotest/neotest-plenary' },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
       'nvim-neotest/neotest-go',
    },
    opts = {
      adapters = { 'neotest-plenary' },
      -- Example for loading neotest-go with a custom config
      -- adapters = {
      --   ['neotest-go'] = {
      --     args = { '-tags=integration' },
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
    config = function()
    -- get neotest namespace (api call creates or returns namespace)
    local neotest_ns = vim.api.nvim_create_namespace('neotest')
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message =
            diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
          return message
        end,
      },
    }, neotest_ns)
    require('neotest').setup({
      -- your neotest config here
      adapters = {
        require('neotest-go'),
      },
    })
  end,
  },
}
