vim.g.mapleader = " "

--[[
-- ordering issue
-- helper tries to load `lazy.core.util` and fails
-- lazy needs the leader key mapped before other plugins
-- are loaded though
--
-- temporarily disable until 0.9.x
--
local helpers = require('fearphage.helpers')
]]

vim.keymap.set("n", ";", ":")
vim.keymap.set("n", ";;", ";")
vim.keymap.set("n", "<leader>/", vim.cmd.nohlsearch, { silent = true })
-- vim.keymap.set("n", "<leader>e", function() vim.lsp.diagnostic.show_line_diagnostics() end, { remap = false, silent = true })
-- vim.keymap.set("n", "<C-h>", "<C-w>h")
-- vim.keymap.set("n", "<C-j>", "<C-w>j")
-- vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true })
-- vim.keymap.set("n", "<C-l>", "<C-w>l")

-- number manipulation
vim.keymap.set('n', '+', '<C-a>', { noremap = true })
vim.keymap.set('n', '-', '<C-x>', { noremap = true })

-- Quickfix
vim.keymap.set('', '<C-n>', ':cnext<CR>zz', {})
vim.keymap.set('', '<C-m>', ':cprevious<CR>zz', {})
vim.keymap.set('n', '<leader>a', ':cclose<CR>', { noremap = true })

-- highlights under cursor
--[[
if helpers.has("nvim-0.9.0") then
  vim.keymap.set("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
end
]]

-- buffers
-- if helpers.has_plugin("nvim-bufferline.lua") then
  vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
  vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
  vim.keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
  vim.keymap.set("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
--[[
else
  vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
  vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
end
]]

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- LSP
-- local opts = { noremap = true, silent = true }
-- vim.keymap.set('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', opts)
-- vim.keymap.set('n', 'tt', ':lua vim.lsp.buf.type_definition()<CR>', opts)
-- vim.keymap.set('n', 'gr', ':lua vim.lsp.buf.references()<CR>', opts)
-- vim.keymap.set('n', 'g0', ':lua vim.lsp.buf.document_symbol()<CR>', opts)
-- vim.keymap.set('n', 'gW', ':lua vim.lsp.buf.workspace_symbol()<CR>', opts)
-- vim.keymap.set('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>', opts)
-- vim.keymap.set('n', '<leader>cl', ':lua vim.lsp.codelens.run()<CR>', opts)

--[[
--
-- From ThePrimeagen below
--
--]]
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
