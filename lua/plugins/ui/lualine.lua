-- status line
return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'glepnir/lspsaga.nvim',
  },
  event = 'VeryLazy',
  config = function()
    local function lspsaga_symbols()
      local exclude = {
        ['terminal'] = true,
        ['toggleterm'] = true,
        ['prompt'] = true,
        ['help'] = true,
        ['starter'] = true,
      }
      if vim.api.nvim_win_get_config(0).zindex or exclude[vim.bo.filetype] then
        return '' -- Excluded filetypes
      else
        local ok, lspsaga = pcall(require, 'lspsaga.symbolwinbar')
        if ok then
          if lspsaga:get_winbar() ~= nil then
            return lspsaga:get_winbar()
          else
            return '' -- Cannot get node
          end
        else
          return '' -- Lspsaga was not loaded yet
        end
      end
    end

    require('lualine').setup({
      options = {
        theme = 'auto',
        -- theme = "gruvbox",
        -- theme = "nightfox",
        globalstatus = true,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = {
          'diff',
          'diagnostics',
          'overseer',
          lspsaga_symbols,
        },
        lualine_x = {
          'searchcount',
          'filetype',
          'fileformat',
          'encoding',
          -- {
          --   require('noice').api.statusline.mode.get,
          --   cond = require('noice').api.statusline.mode.has,
          --   color = { fg = '#ff9e64' },
          -- },
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      extensions = { 'quickfix', 'toggleterm', 'man', 'nvim-dap-ui' },
    })
  end,
}
