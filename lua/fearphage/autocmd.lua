local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local helpers = require('fearphage.helpers')

local opts = { clear = true }

local auto_create_dirs = augroup('auto-create-dirs', opts)
local auto_resize_splits = augroup('auto-resize-splits', opts)
local non_utf8_file = augroup('non-utf8-file', opts)
local restore_position = augroup('restore-position', opts)
local trim_trailing_space = augroup('trim-trailing-space', opts)
local yank_group = augroup('highlight-yank', opts)

-- yank highlight
autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 40,
    })
  end,
})

autocmd({ "BufWritePre" }, {
  desc = 'trim trailing whitespace on save',
  group = trim_trailing_space,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})


-- adapted from https://github.com/ethanholz/nvim-lastplace/blob/main/lua/nvim-lastplace/init.lua
local ignore_buftype = { "help", "nofile", "quickfix" }
local ignore_filetype = { "gitcommit", "gitrebase", "hgcommit", "svn" }

autocmd({ 'BufWinEnter', 'FileType' }, {
  desc     = 'conditionally restore cursor position',
  group    = restore_position,
  callback = function()
    if vim.tbl_contains(ignore_buftype, vim.bo.buftype) then
      return
    end

    if vim.tbl_contains(ignore_filetype, vim.bo.filetype) then
      -- reset cursor to first line
      vim.cmd [[normal! gg]]
      return
    end

    -- If a line has already been specified on the command line, we are done
    --   nvim file +num
    if vim.fn.line(".") > 1 then
      return
    end

    local last_line = vim.fn.line([['"]])
    local buff_last_line = vim.fn.line("$")

    -- If the last line is set and the less than the last line in the buffer
    if last_line > 0 and last_line <= buff_last_line then
      local win_last_line = vim.fn.line("w$")
      local win_first_line = vim.fn.line("w0")
      -- Check if the last line of the buffer is the same as the win
      if win_last_line == buff_last_line then
        -- Set line to last line edited
        vim.cmd [[normal! g`"]]
        -- Try to center
      elseif buff_last_line - last_line > ((win_last_line - win_first_line) / 2) - 1 then
        vim.cmd [[normal! g`"zz]]
      else
        vim.cmd [[normal! G'"<c-e>]]
      end
    end
  end,
})

autocmd({ "BufRead" }, {
  desc = 'warn when file is not in utf-8 format',
  pattern = "*",
  group = non_utf8_file,
  callback = function()
    if vim.bo.fileencoding ~= "utf-8" then
      vim.notify("File not in UTF-8 format!", vim.log.levels.WARN, { title = "nvim-config" })
    end
  end,
})

autocmd({ 'BufWritePre' }, {
  desc = 'create intermediate directories on save',
  pattern = '*',
  group = auto_create_dirs,
  callback = function(ctx)
    local dir = vim.fn.fnamemodify(ctx.file, ':p:h')
    helpers.ensure_dir(dir)
  end,
})

autocmd({ 'VimResized' }, {
  desc = 'auto-resize splits when the terminal is resized',
  group = auto_resize_splits,
  command = 'wincmd =',
})
