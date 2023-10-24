local helpers = require('fearphage.helpers')

return {
  'nvim-telescope/telescope.nvim',
  event = { 'VeryLazy' },
  -- version = false, -- telescope did only one release, so use HEAD for now
  keys = {
    { '<leader>,', '<cmd>Telescope buffers show_all_buffers=true<cr>', desc = 'Switch Buffer' },
    { '<leader>/', helpers.telescope('live_grep'), desc = 'Find in Files (Grep)' },
    { '<leader>:', '<cmd>Telescope command_history<cr>', desc = 'Command History' },
    { '<leader><space>', helpers.telescope('files'), desc = 'Find Files (root dir)' },
    -- find
    { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
    { '<leader>ff', helpers.telescope('files'), desc = 'Find Files (root dir)' },
    { '<leader>fF', helpers.telescope('files', { cwd = false }), desc = 'Find Files (cwd)' },
    { '<leader>fr', '<cmd>Telescope oldfiles<cr>', desc = 'Recent' },
    -- git
    { '<leader>gc', '<cmd>Telescope git_commits<CR>', desc = 'commits' },
    { '<leader>gs', '<cmd>Telescope git_status<CR>', desc = 'status' },
    -- search
    { '<leader>sa', '<cmd>Telescope autocommands<cr>', desc = 'Auto Commands' },
    { '<leader>sb', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = 'Buffer' },
    { '<leader>sc', '<cmd>Telescope command_history<cr>', desc = 'Command History' },
    { '<leader>sC', '<cmd>Telescope commands<cr>', desc = 'Commands' },
    { '<leader>sd', '<cmd>Telescope diagnostics<cr>', desc = 'Diagnostics' },
    { '<leader>sg', helpers.telescope('live_grep'), desc = 'Grep (root dir)' },
    { '<leader>sG', helpers.telescope('live_grep', { cwd = false }), desc = 'Grep (cwd)' },
    { '<leader>sh', '<cmd>Telescope help_tags<cr>', desc = 'Help Pages' },
    { '<leader>sH', '<cmd>Telescope highlights<cr>', desc = 'Search Highlight Groups' },
    { '<leader>sk', '<cmd>Telescope keymaps<cr>', desc = 'Key Maps' },
    { '<leader>sM', '<cmd>Telescope man_pages<cr>', desc = 'Man Pages' },
    { '<leader>sm', '<cmd>Telescope marks<cr>', desc = 'Jump to Mark' },
    { '<leader>so', '<cmd>Telescope vim_options<cr>', desc = 'Options' },
    { '<leader>sw', helpers.telescope('grep_string'), desc = 'Word (root dir)' },
    { '<leader>sW', helpers.telescope('grep_string', { cwd = false }), desc = 'Word (cwd)' },
    { '<leader>uC', helpers.telescope('colorscheme', { enable_preview = true }), desc = 'Colorscheme with preview' },
    { '<leader>ss', helpers.telescope('lsp_document_symbols', {
        symbols = {
          'Class',
          'Function',
          'Method',
          'Constructor',
          'Interface',
          'Module',
          'Struct',
          'Trait',
          'Field',
          'Property',
        },
      }),
      desc = 'Goto Symbol',
    },
  },
  dependencies = {
    {
      'stevearc/aerial.nvim',
      { -- https://github.com/nvim-telescope/telescope-frecency.nvim
        'nvim-telescope/telescope-frecency.nvim',
        dependencies = {
          { 'tami5/sqlite.lua' }, -- https://github.com/tami5/sqlite.lua
        },
      },
      { -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
    },
  },
  opts = {
    defaults = {
      dynamic_preview_title = true,
      laout_strategy = 'flex',
      mappings = {
        i = {
          ['<c-t>'] = function(...)
            return require('trouble.providers.telescope').open_with_trouble(...)
          end,
          ['<a-i>'] = function()
            helpers.telescope('find_files', { no_ignore = true })()
          end,
          ['<a-h>'] = function()
            helpers.telescope('find_files', { hidden = true })()
          end,
          ['<C-Down>'] = function(...)
            return require('telescope.actions').cycle_history_next(...)
          end,
          ['<C-Up>'] = function(...)
            return require('telescope.actions').cycle_history_prev(...)
          end,
        },
        n = {
          ['<c-t>'] = function(...)
            return require('trouble.providers.telescope').open_with_trouble(...)
          end,
        },
      },
      path_display = { 'smart', truncate = 3 },
      prompt_prefix = ' ',
      scroll_stratgey = 'cycle',
      selection_caret = ' ',
    },
    extensions = {
      frecency = { workspaces = {} },
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = 'smart_case',
      },
    },
    pickers = {
        buffers = {
        show_all_buffers = true,
        previewer = false,
        sort_lastused = true,
        theme = 'ivy',
      },
      find_files = { theme = 'ivy' },
      file_browser = { theme = 'ivy' },
      grep_string = { theme = 'ivy' },
      live_grep = { theme = 'dropdown' },
      lsp_code_actions = { theme = 'dropdown' },
      lsp_definitions = { theme = 'dropdown' },
      lsp_implementations = { theme = 'dropdown' },
      lsp_references = { theme = 'dropdown' },
    },
  },
  config = function(_, opts)
    require('aerial').setup()

    local telescope = require('telescope')

    -- Extensions
    telescope.load_extension('aerial')
    telescope.load_extension('frecency')
    telescope.load_extension('fzf')
    telescope.load_extension('notify')

    telescope.setup(opts)
  end,
}


