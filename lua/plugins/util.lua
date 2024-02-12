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
    build = function()
      vim.fn['mkdp#util#install']()
    end,
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
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      plugins = { spelling = true },
    },
    config = function(_, opts)
      local wk = require('which-key')
      wk.setup(opts)
      wk.register({
        mode = { 'n', 'v' },
        ['g'] = { name = '+goto' },
        ['gz'] = { name = '+surround' },
        [']'] = { name = '+next' },
        ['['] = { name = '+prev' },
        ['<leader><tab>'] = { name = '+tabs' },
        ['<leader>b'] = { name = '+buffer' },
        ['<leader>c'] = { name = '+code' },
        ['<leader>d'] = { name = '+debug' },
        ['<leader>f'] = { name = '+file/find' },
        ['<leader>g'] = { name = '+git' },
        ['<leader>gh'] = { name = '+hunks' },
        ['<leader>q'] = { name = '+quit/session' },
        ['<leader>s'] = { name = '+search' },
        ['<leader>sn'] = { name = '+noice' },
        ['<leader>u'] = { name = '+ui' },
        ['<leader>w'] = { name = '+windows' },
        ['<leader>x'] = { name = '+diagnostics/quickfix' },
      })
    end,
  },

  'nvim-tree/nvim-web-devicons',

  -- makes some plugins dot-repeatable like leap
  { 'tpope/vim-repeat', event = 'VeryLazy' },
}
