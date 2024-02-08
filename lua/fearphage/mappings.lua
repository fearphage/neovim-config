local enabled = require('fearphage.helpers').enabled
local group = require('fearphage.user-config').enable_plugins
local keymap = require('fearphage.helpers').keymap

vim.g.mapleader = ' '

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

keymap('n', ';', ':')
keymap('n', ';;', ';')
keymap('n', '<leader>/', vim.cmd.nohlsearch, { silent = true })
-- vim.keymap.set('n', '<leader>e', function() vim.lsp.diagnostic.show_line_diagnostics() end, { remap = false, silent = true })
-- vim.keymap.set('n', '<C-h>', '<C-w>h')
-- vim.keymap.set('n', '<C-j>', '<C-w>j')
-- vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true })
-- vim.keymap.set('n', '<C-l>', '<C-w>l')

-- number manipulation
keymap('n', '+', '<C-a>', { noremap = true })
keymap('n', '-', '<C-x>', { noremap = true })

-- Quickfix
keymap('', '<C-n>', ':cnext<CR>zz', {})
keymap('', '<C-m>', ':cprevious<CR>zz', {})
keymap('n', '<leader>a', ':cclose<CR>', { noremap = true })

-- highlights under cursor
--[[
if helpers.has('nvim-0.9.0') then
  vim.keymap.set('n', '<leader>ui', vim.show_pos, { desc = 'Inspect Pos' })
end
]]

-- buffers
-- if helpers.has_plugin('nvim-bufferline.lua') then
keymap('n', '<S-h>', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Prev buffer' })
keymap('n', '<S-l>', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next buffer' })
keymap('n', '[b', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Prev buffer' })
keymap('n', ']b', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next buffer' })
--[[
else
  vim.keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev buffer' })
  vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next buffer' })
  vim.keymap.set('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev buffer' })
  vim.keymap.set('n', ']b', '<cmd>bnext<cr>', { desc = 'Next buffer' })
end
]]

-- Resize window using <ctrl> arrow keys
keymap('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
keymap('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
keymap('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
keymap('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })

-- LSP
-- local opts = { noremap = true, silent = true }
-- keymap('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', opts)
-- keymap('n', 'tt', ':lua vim.lsp.buf.type_definition()<CR>', opts)
-- keymap('n', 'gr', ':lua vim.lsp.buf.references()<CR>', opts)
-- keymap('n', 'g0', ':lua vim.lsp.buf.document_symbol()<CR>', opts)
-- keymap('n', 'gW', ':lua vim.lsp.buf.workspace_symbol()<CR>', opts)
-- keymap('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>', opts)
-- keymap('n', '<leader>cl', ':lua vim.lsp.codelens.run()<CR>', opts)

--[[
--
-- From ThePrimeagen below
--
--]]
keymap('n', '<leader>pv', vim.cmd.Ex)

keymap('v', 'J', ":m '>+1<CR>gv=gv")
keymap('v', 'K', ":m '<-2<CR>gv=gv")

keymap('n', 'J', 'mzJ`z')
keymap('n', '<C-d>', '<C-d>zz')
keymap('n', '<C-u>', '<C-u>zz')
keymap('n', 'n', 'nzzzv')
keymap('n', 'N', 'Nzzzv')

keymap('n', '<leader>vwm', function()
  require('vim-with-me').StartVimWithMe()
end)
keymap('n', '<leader>svwm', function()
  require('vim-with-me').StopVimWithMe()
end)

-- greatest remap ever
keymap('x', '<leader>p', [['_dP]])

-- next greatest remap ever : asbjornHaland
keymap({ 'n', 'v' }, '<leader>y', [['+y]])
keymap('n', '<leader>Y', [['+Y]])

keymap({ 'n', 'v' }, '<leader>d', [['_d]])

-- This is going to get me cancelled
keymap('i', '<C-c>', '<Esc>')

keymap('n', 'Q', '<nop>')
keymap('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')
keymap('n', '<leader>f', vim.lsp.buf.format)

-- keymap('n', '<C-k>', '<cmd>cnext<CR>zz')
-- keymap('n', '<C-j>', '<cmd>cprev<CR>zz')
keymap('n', '<leader>k', '<cmd>lnext<CR>zz')
keymap('n', '<leader>j', '<cmd>lprev<CR>zz')

keymap('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

if enabled(group, 'dap') then
  -- _G.dap = require('dap')
  -- keymap('n', '<leader>dc', '<CMD>lua dap.continue()<CR>')
  keymap('n', '<leader>dc', '<CMD>DapContinue<CR>')
  -- keymap('n', '<leader>n', '<CMD>lua dap.step_over()<CR>')
  keymap('n', '<leader>n', '<CMD>DapStepOver<CR>')
  -- keymap('n', '<leader>si', '<CMD>lua dap.step_into()<CR>')
  keymap('n', '<leader>si', '<CMD>DapStepInto<CR>')
  -- keymap('n', '<leader>so', '<CMD>lua dap.step_out()<CR>')
  keymap('n', '<leader>so', '<CMD>DapStepOut<CR>')
  -- keymap('n', '<leader>b', '<CMD>lua dap.toggle_breakpoint()<CR>')
  -- keymap('n', '<leader>db', '<CMD>lua dap.toggle_breakpoint()<CR>', {
  keymap('n', '<leader>db', '<CMD>DapToggleBreakpoint<CR>', {
    desc = 'Toggle breakpoint at line',
  })
  keymap('n', '<leader>dq', '<CMD>lua dap.disconnect({ terminateDebuggee = true })<CR>')
  keymap(
    'n',
    '<leader>dus',
    '<CMD>lua require("dapui").toggle()<CR>',
    -- keymap('n', '<leader>dus', function()
    --   local widgets = require('dap.ui.widgets')
    --   local sidebar = widgets.sidebar(widgets.scopes)
    --   sidebar.open()
    -- end,
    { desc = 'Open debugging sidebar' }
  )
  keymap('n', '<leader>dgt', '<CMD>lua require("dap-go").debug_test()<CR>')
end

keymap({ 'i', 'n', 's', 'x' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save file' })
keymap('v', '<C-s>', ':sort i<CR>', { desc = 'Sort selection' })
keymap('v', '<leader>S', ':sort i<CR>', { desc = 'Sort selection' })
keymap('n', ']d', '<CMD>lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = lvim.lsp.popup_border } })<CR>')
keymap('n', '[d', '<CMD>lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = lvim.lsp.popup_border } })<CR>')
