return {
  -- tmux
  {
    "christoomey/vim-tmux-navigator",
    -- cmd = { "TmuxNavigateDown", "TmuxNavigateLeft", "TmuxNavigateRight", "TmuxNavigateUp", },
    event = 'VeryLazy',
  },

  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    cmd = 'MarkdownPreview',
  },

  {
    "kylechui/nvim-surround",
    config = true,
    event = 'VeryLazy',
    version = "*",
  },

  {
    'numToStr/Comment.nvim',
    config = true,
    event = 'VeryLazy',
  },

  'kyazdani42/nvim-web-devicons',

  -- makes some plugins dot-repeatable like leap
  { "tpope/vim-repeat", event = "VeryLazy" },
}
