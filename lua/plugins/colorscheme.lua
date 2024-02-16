return {

  -- catppuccin
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = true,
    opts = {
      dim_inactive = {
        enabled = true,
      },
      transparent_background = true,
    },
  },

  -- gruvbox
  {
    'ellisonleao/gruvbox.nvim',
    lazy = true,
    opts = {
      transparent = true,
      transparent_mode = true,
    },
  },

  -- kanagawa
  {
    'rebelot/kanagawa.nvim',
    lazy = true,
    opts = {
      transparent = true,
    },
  },

  -- nightfox
  {
    'EdenEast/nightfox.nvim',
    lazy = true,
    opts = {
      transparent = true,
    },
  },

  -- rose-pine
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = true,
  },

  -- tokyonight
  {
    'folke/tokyonight.nvim',
    lazy = true,
    opts = {
      -- floats = 'transparent',
      style = 'moon',
      transparent = true,
    },
  },
}
