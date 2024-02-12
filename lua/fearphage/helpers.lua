local fn = vim.fn
-- not used... yet
-- local Util = require('lazy.core.util')

local M = {}

--[[ unused
function M.deprecate(old, new)
  Util.warn(('`%s` is deprecated. Please use `%s` instead'):format(old, new), { title = 'LazyVim' })
end
]]

-- creates floating terminal for toggleterm
function M.create_floating_terminal(term, cmd)
  local instance = nil

  if fn.executable(cmd) == 1 then
    local terminal = term.Terminal
    instance = terminal:new({
      cmd = cmd,
      dir = 'git_dir',
      direction = 'float',
      float_opts = {
        border = 'double',
      },
      on_open = function()
        vim.cmd('startinsert!')
      end,
      on_close = function()
        vim.cmd('startinsert!')
      end,
    })
  end

  -- check if TermExec function exists
  return function()
    if fn.executable(cmd) == 1 then
      instance:toggle()
    else
      vim.notify('Command not found: ' .. cmd .. '. Ensure it is installed.', 'error')
    end
  end
end

-- check if option to disable is active from specified group
function M.enabled(group, opt)
  return group == nil or group[opt] == nil or group[opt] == true
end

function M.ensure_dir(dir)
  if fn.isdirectory(dir) == 0 then
    fn.mkdir(dir, 'p')
  end
end

function M.get_nvm_version()
  local actual_version = vim.version()

  return string.format('%d.%d.%d', actual_version.major, actual_version.minor, actual_version.patch)
end

M.root_patterns = {
  '.git',
  'lua',
}

-- source: https://github.com/LazyVim/LazyVim/blob/99ee77a03d54553ce784da0e887fa8c1abeec865/lua/lazyvim/util/init.lua#L33
-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
function M.get_root()
  ---@type string?
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= '' and vim.loop.fs_realpath(path) or nil
  ---@type string[]
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws)
        return vim.uri_to_fname(ws.uri)
      end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
      for _, p in ipairs(paths) do
        local r = vim.loop.fs_realpath(p)
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end

  table.sort(roots, function(a, b)
    return #a > #b
  end)
  ---@type string?
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or vim.loop.cwd()
    ---@type string?
    root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.loop.cwd()
  end
  ---@cast root string
  return root
end

function M.has(feature)
  return fn.has(feature) == 1
end

function M.has_plugin(plugin)
  return require('lazy.core.config').plugins[plugin] ~= nil
end

-- helper for cmp completion
function M.has_words_before()
  local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

function M.keymap(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }

  if opts then
    options = vim.tbl_extend('force', options, opts)
  end

  vim.keymap.set(mode, lhs, rhs, options)
end

-- this will return a function that calls telescope.
-- cwd will defautlt to lazyvim.util.get_root
-- for `files`, git_files or find_files will be chosen depending on .git
function M.telescope(builtin, opts)
  local params = { builtin = builtin, opts = opts }
  return function()
    builtin = params.builtin
    opts = params.opts
    opts = vim.tbl_deep_extend('force', { cwd = M.get_root() }, opts or {})
    if builtin == 'files' then
      if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. '/.git') then
        opts.show_untracked = true
        builtin = 'git_files'
      else
        builtin = 'find_files'
      end
    end
    require('telescope.builtin')[builtin](opts)
  end
end

return M
