return {
  -- easily jump to any location and enhanced f/t motions for Leap
  'ggandor/leap.nvim',
  keys = {
    { 's', '<Plug>(leap-forward)', mode = { 'n', 'x', 'o' }, desc = 'Leap forward to' },
    { '<M-s>', '<Plug>(leap-backward)', mode = { 'n', 'x', 'o' }, desc = 'Leap backward to' },
    { 'gs', '<Plug>(leap-from-window)', mode = { 'n', 'x', 'o' }, desc = 'Leap from window' },
  },
  opts = {
    labels = 'fnjklhodweimbuyvrgtaqpcxz/FNJKLHODWEIMBUYVRGTAQPCXZ?',
    safe_labels = 'fnut/FNLHMUGTZ?',
  },
}
