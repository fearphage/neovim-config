if vim.fn.has('unix') and vim.env.NEOVIM_NODE_VERSION then
  local node_dir

  -- stylua: ignore
  if vim.env.FNM_BIN then
    node_dir = vim.env.HOME .. '/.local/share/fnm/node-versions/' .. vim.env.NEOVIM_NODE_VERSION .. '/installation/bin/'
  elseif vim.env.NVM_BIN then
	  node_dir = vim.env.HOME .. '/nvm/versions/node/' .. vim.env.NEOVIM_NODE_VERSION .. '/bin/'
  -- else
  --   node_dir = vim.fn.system({})
  end

  if node_dir and vim.fn.isdirectory(node_dir) then
    vim.env.PATH = node_dir .. ':' .. vim.env.PATH
  end
end

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

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
  install = { colorscheme = { 'catppuccin', 'gruvbox', 'habamax', 'nightfox', 'rose-pine', 'tokyonight' } },
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
