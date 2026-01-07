return {
  'iamcco/markdown-preview.nvim',
  -- build = function() vim.fn['mkdp#util#install']() end,
  build = 'cd app && yarn install',
  cmd = 'MarkdownPreview',
  ft = 'markdown',
}
