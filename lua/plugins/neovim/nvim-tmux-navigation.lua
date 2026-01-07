return {
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
}
