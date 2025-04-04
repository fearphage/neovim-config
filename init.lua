if vim.fn.has('unix') and vim.env.NEOVIM_NODE_VERSION then
  local node_dir

  -- stylua: ignore
  if vim.env.FNM_BIN then
    node_dir = vim.env.HOME .. '/.local/share/fnm/node-versions/' .. vim.env.NEOVIM_NODE_VERSION .. '/installation/bin/'
  elseif vim.env.NVM_BIN then
    node_dir = vim.env.HOME .. '/.nvm/versions/node/' .. vim.env.NEOVIM_NODE_VERSION .. '/bin/'
  -- else
  --   node_dir = vim.fn.system({})
  end

  if node_dir and vim.fn.isdirectory(node_dir) then
    vim.env.PATH = node_dir .. ':' .. vim.env.PATH
  end
end

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

require('lazy').setup({
  spec = {
    -- add LazyVim and import its plugins
    { 'LazyVim/LazyVim', import = 'lazyvim.plugins' },
    -- import any extras modules here
    -- { import = 'lazyvim.plugins.extras.lang.typescript' },
    -- { import = 'lazyvim.plugins.extras.lang.json' },
    -- { import = 'lazyvim.plugins.extras.ui.mini-animate' },
    -- import/override with your plugins
    { import = 'plugins' },
    { import = 'plugins.themes' },
  },
  -- limits concurrency to prevent 'fetch failed' errors
  -- https://github.com/folke/lazy.nvim/issues/648#issuecomment-1753316146
  concurrency = 16,
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = '*', -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { 'catppuccin', 'gruvbox', 'habamax', 'kanagawa', 'nightfox', 'rose-pine', 'tokyonight' } },
  colorscheme = 'tokyonight',
  checker = { enabled = false }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        'gzip',
        -- 'matchit',
        -- 'matchparen',
        -- 'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})
