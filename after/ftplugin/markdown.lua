local map = vim.keymap.set
local opts = { noremap = true, silent = true, buffer = 0 }

-- search markdown links
map('n', '<Tab>', "<Cmd>call search('\\[[^]]*\\]([^)]\\+)')<CR>", opts)
map('n', '<S-Tab>', "<Cmd>call search('\\[[^]]*\\]([^)]\\+)', 'b')<CR>", opts)

local buf = vim.api.nvim_get_current_buf()
map('n', '<C-S>p', '<cmd>MarkdownPreview<cr>', { buffer = buf })
map('n', '<C-p>', '<cmd>MarkdownPreview<cr>', { buffer = buf })
