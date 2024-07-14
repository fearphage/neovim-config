return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-neotest/neotest-go',
      'rouge8/neotest-rust',
    },
    config = function()
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
        adapters = {
          require('neotest-go'),
          require('neotest-rust')({ args = { '--no-capture' }, dap_adapter = 'codelldb' }),
        },

        -- output = { enabled = true, open_on_run = true },
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
        status = {
          enabled = true,
          signs = true,
          virtual_text = true,
        },
      })
    end,
  },
}
