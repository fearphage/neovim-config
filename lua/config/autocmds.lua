local api = vim.api

local helpers = require('fearphage.helpers')

-- adapted from https://github.com/ethanholz/nvim-lastplace/blob/main/lua/nvim-lastplace/init.lua
local restore_position = api.nvim_create_augroup('restore-position', {})

local ignore_buftype = { 'help', 'nofile', 'quickfix' }
local ignore_filetype = { 'gitcommit', 'gitrebase', 'hgcommit', 'svn' }

api.nvim_create_autocmd({ 'BufWinEnter', 'FileType' }, {
  desc = 'conditionally restore cursor position',
  group = restore_position,
  callback = function()
    if vim.tbl_contains(ignore_buftype, vim.bo.buftype) then
      return
    end

    if vim.tbl_contains(ignore_filetype, vim.bo.filetype) then
      -- reset cursor to first line
      vim.cmd([[normal! gg]])
      return
    end

    -- If a line has already been specified on the command line, we are done
    --   nvim file +num
    if vim.fn.line('.') > 1 then
      return
    end

    local last_line = vim.fn.line([['"]])
    local buff_last_line = vim.fn.line('$')

    -- If the last line is set and the less than the last line in the buffer
    if last_line > 0 and last_line <= buff_last_line then
      local win_last_line = vim.fn.line('w$')
      local win_first_line = vim.fn.line('w0')
      -- Check if the last line of the buffer is the same as the win
      if win_last_line == buff_last_line then
        -- Set line to last line edited
        vim.cmd([[normal! g`"]])
        -- Try to center
      elseif buff_last_line - last_line > ((win_last_line - win_first_line) / 2) - 1 then
        vim.cmd([[normal! g`"zz]])
      else
        vim.cmd([[normal! G'"<c-e>]])
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
      -- { 'BufEnter', '*', [[setlocal  cursorline]] },
      --
      {
        'BufEnter,CmdlineLeave,FocusGained,InsertLeave,WinEnter',
        '*',
        [[if &number | setlocal relativenumber | endif]],
        'conditionally toggle relative line numbers (for pairing)',
      },
      {
        'BufLeave,CmdlineEnter,FocusLost,InsertEnter,WinLeave',
        '*',
        [[if &number | setlocal norelativenumber | endif]],
        'conditionally toggle relative line numbers (for pairing)',
      },
      {
        'BufRead',
        '*',
        function()
          if vim.bo.fileencoding ~= 'utf-8' then
            vim.notify('File not in UTF-8 format!', vim.log.levels.WARN, { title = 'nvim-config' })
          end
        end,
        'warn when file is not in utf-8 format',
      },
      { 'BufWritePost', '*.mod, *.sum', ':silent :GoModTidy' },
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
        'FileType',
        'gitcommit,markdown,rst',
        function()
          vim.cmd([[setlocal spell]])
          vim.cmd([[setlocal complete+=kspell]])
        end,
      },
      -- { -- moved to after/
      --   'FileType',
      --   -- this doesn't work for lua
      --   'json,lua',
      --   function()
      --     helpers.keymap('n', 'o', function()
      --       local line = vim.api.nvim_get_current_line()
      --       local should_add_comma = string.find(line, '[^,{[]$')
      --
      --       if should_add_comma then
      --         return 'A,<cr>'
      --       else
      --         return 'o'
      --       end
      --     end, { buffer = true, expr = true })
      --   end,
      --   'append a trailing comma automatically when you start editing the next line',
      -- },
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
      {
        'VimResized',
        '*',
        [[tabdo wincmd =]],
        'auto-resize splits when the terminal is resized',
      },
    },
  }

  autocommands.create_autogroups(definitions)
end

autocommands.load_commands()
return autocommands
