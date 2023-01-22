function ColorMeSurprised(color)
  -- vim.cmd.colorscheme(color or "catppuccin")
  -- vim.cmd.colorscheme(color or "gruvbox")
  vim.cmd.colorscheme(color or "nightfox")
  -- vim.cmd.colorscheme(color or "rose-pine")
  -- vim.cmd.colorscheme(color or "tokyonight")

  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
end

ColorMeSurprised()
