local enabled = require('fearphage.helpers').enabled
local group = require('fearphage.user-config').enable_plugins

return {
  'mfussenegger/nvim-dap',
  -- cond = enabled(group, 'dap'),
  event = 'VeryLazy',
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end

    vim.fn.sign_define('DapBreakpoint', { text = '🔴' })
    -- vim.fn.sign_define('DapStopped', { text = '⚡' })
    vim.fn.sign_define('DapStopped', { text = '👉' })
  end,
  dependencies = {
    {
      'jay-babu/mason-nvim-dap.nvim',
      config = function()
        require('mason-nvim-dap').setup()
      end,
    },
    {
      'rcarriga/nvim-dap-ui',
      config = function()
        require('dapui').setup()
      end,
    },
    {
      'theHamsta/nvim-dap-virtual-text',
      config = function()
        require('nvim-dap-virtual-text').setup()
      end,
    },
  },
}
