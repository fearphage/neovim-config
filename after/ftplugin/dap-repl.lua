vim.keymap.inoremap({ '<C-h>', '<Esc><C-w>h', { buffer = 0 } })
vim.keymap.inoremap({ '<C-j>', '<Esc><C-w>j', { buffer = 0 } })
vim.keymap.inoremap({ '<C-k>', '<Esc><C-w>k', { buffer = 0 } })
vim.keymap.inoremap({ '<C-l>', '<Esc><C-w>l', { buffer = 0 } })

vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.opt_local.cursorcolumn = false

require('dap.ext.autocompl').attach()
