vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.colorcolumn = '80'
vim.opt.expandtab = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.number = true
-- vim.opt.relativenumber = true -- this is toggled automatically for active windows in autocmds
vim.opt.scrolloff = 8
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.splitbelow = true -- new windows open below current
vim.opt.splitright = true -- new windows open to the right of current
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.undodir = os.getenv('HOME') .. '/.vim/tmp/undo'
vim.opt.undofile = true
vim.opt.winborder = 'rounded'
vim.opt.wrap = false

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.filetype.add({
  filename = {
    ['Jenkinsfile'] = 'groovy',
  },

  pattern = {
    ['Dockerfile.*'] = 'dockerfile',
  },
})

vim.g.linterConfigs = vim.fs.normalize('~/.config/+ linter-configs/')

-- LLM model
-- _G.COPILOT_MODEL = 'gpt-4o'
_G.COPILOT_MODEL = 'claude-3.7-sonnet'

-- disable mini.pairs
vim.g.minipairs_disable = true
