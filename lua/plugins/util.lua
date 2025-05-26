return {
  -- tmux
  {
    'alexghergh/nvim-tmux-navigation',
    keys = {
      { '<C-h>', '<Cmd>NvimTmuxNavigateLeft<CR>', desc = 'Left window' },
      { '<C-j>', '<Cmd>NvimTmuxNavigateDown<CR>', desc = 'Up window' },
      { '<C-k>', '<Cmd>NvimTmuxNavigateUp<CR>', desc = 'Down window' },
      { '<C-l>', '<Cmd>NvimTmuxNavigateRight<CR>', desc = 'Right window' },
    },
    lazy = false,
    opts = {
      disable_when_zoomed = true,
    },
  },

  {
    'iamcco/markdown-preview.nvim',
    -- build = function() vim.fn['mkdp#util#install']() end,
    build = 'cd app && yarn install',
    cmd = 'MarkdownPreview',
    ft = 'markdown',
  },

  {
    'kylechui/nvim-surround',
    config = true,
    event = 'VeryLazy',
    version = '*',
  },

  {
    'numToStr/Comment.nvim',
    config = true,
    event = 'VeryLazy',
  },

  {
    'junegunn/fzf.vim',
    keys = {
      { '<C-p>', '<cmd>Files<cr>', { silent = true, noremap = true } },
      { '<C-b>', '<cmd>Buffers<cr>', { silent = true, noremap = true } },
      { '<C-t>', '<cmd>Rg<cr>', { silent = true, noremap = true } },
    },
    dependencies = {
      {
        'junegunn/fzf',
        build = function()
          vim.fn['fzf#install']()
        end,
      },
    },
    event = 'VeryLazy',
  },

  'nvim-tree/nvim-web-devicons',

  -- makes some plugins dot-repeatable like leap
  { 'tpope/vim-repeat', event = 'VeryLazy' },
}
