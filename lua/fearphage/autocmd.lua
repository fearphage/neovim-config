local api = vim.api

local helpers = require('fearphage.helpers')

-- adapted from https://github.com/ethanholz/nvim-lastplace/blob/main/lua/nvim-lastplace/init.lua
local restore_position = api.nvim_create_augroup('restore-position', {})

local ignore_buftype = { "help", "nofile", "quickfix" }
local ignore_filetype = { "gitcommit", "gitrebase", "hgcommit", "svn" }

api.nvim_create_autocmd({ 'BufWinEnter', 'FileType' }, {
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

local autocommands = {}
function autocommands.create_autogroups(definitions)
  for group_name, defs in pairs(definitions) do
    local group = api.nvim_create_augroup('local-augroup-' .. group_name, {})
    for _, def in ipairs(defs) do
      local opts = {
        group = group,
        pattern = def[2],
      }

      if type(def[3]) == 'string' then
        opts.command = def[3]
      else
        opts.callback = def[3]
      end

      if def[4] then
        opts.desc = def[4]
      end

      api.nvim_create_autocmd(vim.split(def[1], ','), opts)
    end
  end
end

function autocommands.load_commands()
  local definitions = {
    buffers = {
      {
        'BufRead',
        "*",
        function()
          if vim.bo.fileencoding ~= "utf-8" then
            vim.notify("File not in UTF-8 format!", vim.log.levels.WARN, { title = "nvim-config" })
          end
        end,
        'warn when file is not in utf-8 format',
      },
      {
        'BufWritePre',
        '*',
        function(ctx)
          local dir = vim.fn.fnamemodify(ctx.file, ':p:h')
          helpers.ensure_dir(dir)
        end,
        'create intermediate directories on save',
      },
      {
        'BufWritePre',
        '*',
        [[%s/\s\+$//e]],
        'trim trailing whitespace on save',
      },
    },
    windows = {
      {
        'VimResized',
        '*',
        [[tabdo windcmd =]],
        'auto-resize splits when the terminal is resized',
      },
      {
        'TextYankPost',
        '*',
        function()
          vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
          })
        end,
        'highlight on yank',
      },
    },
  }

  autocommands.create_autogroups(definitions)
end

autocommands.load_commands()
return autocommands
