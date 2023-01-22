vim.opt.colorcolumn = '80'

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.scrolloff = 8
vim.opt.splitbelow = true -- new windows open below current
vim.opt.splitright = true -- new windows open to the right of current

vim.opt.termguicolors = true

vim.opt.undodir = os.getenv('HOME') .. '/.vim/tmp/undo'
vim.opt.undofile = true

vim.opt.wrap = false

--vim.cmd('let $NVIM_TUI_ENABLE_TRUE_COLOR=1')
--

function R(name)
    require("plenary.reload").reload_module(name)
end

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

