return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-neotest/neotest-go',
      'rouge8/neotest-rust',
    },
    config = function()
      -- get neotest namespace (api call creates or returns namespace)
      local neotest_ns = vim.api.nvim_create_namespace('neotest')
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
            return message
          end,
        },
      }, neotest_ns)

      require('neotest').setup({
        -- adapters = { 'neotest-plenary' },
        adapters = {
          require('neotest-go'),
          require('neotest-rust')({ args = { '--no-capture' }, dap_adapter = 'codelldb' }),
        },

        -- Example for loading neotest-go with a custom config
        -- adapters = {
        --   ['neotest-go'] = {
        --     args = { '-tags=integration' },
        --   },
        -- },
        output = { enabled = true, open_on_run = true },
        quickfix = {
          enabled = true,
          open = function()
            if require('fearphage.helpers').has('trouble.nvim') then
              vim.cmd('Trouble quickfix')
            else
              vim.cmd('copen')
            end
          end,
        },
        status = { enabled = true, virtual_text = true },
      })
    end,
  },
}
