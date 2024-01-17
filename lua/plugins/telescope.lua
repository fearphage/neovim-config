local helpers = require('fearphage.helpers')

return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    -- version = false, -- telescope did only one release, so use HEAD for now
    keys = {
      { '<leader>,', '<cmd>Telescope buffers show_all_buffers=true<cr>', desc = 'Switch Buffer' },
      { '<leader>/', helpers.telescope('live_grep'), desc = 'Find in Files (Grep)' },
      { '<leader>:', '<cmd>Telescope command_history<cr>', desc = 'Command History' },
      { '<leader><space>', helpers.telescope('files'), desc = 'Find Files (root dir)' },
      -- find
      { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
      { '<leader>fc', '<cmd>Telescope git_commits<CR>', desc = 'commits' },
      { '<leader>ff', helpers.telescope('files'), desc = 'Find Files (root dir)' },
      { '<leader>fF', helpers.telescope('files', { cwd = false }), desc = 'Find Files (cwd)' },
      { '<leader>fk', '<cmd>Telescope keymaps<cr>', desc = 'Key Maps' },
      { '<leader>fm', '<cmd>Telescope marks<cr>', desc = 'Marks' },
      { '<leader>fq', '<cmd>Telescope quickfix<cr>', desc = 'Quickfix' },
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
      {
        '<leader>ss',
        helpers.telescope('lsp_document_symbols', {
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
      'nvim-lua/plenary.nvim',
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
        aerial = {
          show_nesting = true,
          theme = 'dropdown',
        },
        file_browser = {
          theme = 'dropdown',
        },
        frecency = {
          db_root = vim.fn.stdpath('data'),
          disable_devicons = false,
          ignore_patterns = {
            '*.git/*',
            '*/tmp/*',
          },
          show_scores = true,
          show_unindexed = true,
          -- workspaces = {},
        },
        fzf = {
          case_mode = 'smart_case',
          fuzzy = true,
          override_file_sorter = true,
          override_generic_sorter = true,
        },
        -- ['ui-select'] = { themes.get_dropdown({}), },
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
    _old_config = function(_, opts)
      -- require('aerial').setup()

      local telescope = require('telescope')

      -- Extensions
      telescope.load_extension('aerial')
      -- telescope.load_extension('frecency')
      telescope.load_extension('fzf')
      telescope.load_extension('notify')

      telescope.setup(opts)
    end,
  },
  {
    'stevearc/aerial.nvim',
    lazy = true,
    keys = {
      { '<leader>ta', '<cmd>Telescope aerial<cr>', desc = 'Aeriel' },
    },
    config = function()
      require('telescope').load_extension('aerial')
    end,
  },
  {
    'gbprod/yanky.nvim',
    lazy = true,
    keys = {
      { '<leader>fp', '<esc><cmd>Telescope yank_history<cr>', desc = 'Yank History' },
    },
    config = function()
      require('telescope').load_extension('yank_history')
    end,
  },
  {
    'nvim-telescope/telescope-frecency.nvim',
    -- dependencies = { 'kkharji/sqlite.lua', },
    lazy = true,
    config = function()
      require('telescope').load_extension('frecency')
    end,
  },
  {
    'nvim-telescope/telescope-github.nvim',
    lazy = true,
    keys = {
      { '<leader>fgg', '<cmd>Telescope gh gist<cr>', desc = 'GitHub Gist' },
      { '<leader>fgi', '<cmd>Telescope gh issues<cr>', desc = 'GitHub Issue' },
      { '<leader>fgp', '<cmd>Telescope gh pull_request<cr>', desc = 'GitHub Pull Request' },
      { '<leader>fgr', '<cmd>Telescope gh run<cr>', desc = 'GitHub Run' },
    },
    config = function()
      require('telescope').load_extension('gh')
    end,
  },
  {
    'HUAHUAI23/telescope-dapzzzz',
    lazy = true,
    config = function()
      require('telescope').load_extension('i23')
    end,
  },
  {
    'nvim-telescope/telescope-dap.nvim',
    lazy = true,
    keys = {
      { '<leader>fdb', '<esc><Cmd>Telescope dap list_breakpoints<cr>', desc = 'DAP Commands' },
      { '<leader>fdc', '<esc><Cmd>Telescope dap configurations<cr>', desc = 'DAP Commands' },
      { '<leader>fdd', '<esc><Cmd>Telescope dap commands<cr>', desc = 'DAP Commands' },
      { '<leader>fdv', '<esc><Cmd>Telescope dap variables<cr>', desc = 'DAP Commands' },
    },
    config = function()
      require('telescope').load_extension('dap')
    end,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    lazy = true,
    build = 'make',
    config = function()
      require('telescope').load_extension('fzf')
    end,
  },
  {
    'LinArcX/telescope-env.nvim',
    lazy = true,
    config = function()
      require('telescope').load_extension('env')
    end,
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    lazy = true,
    config = function()
      require('telescope').load_extension('file_browser')
    end,
  },
  {
    'nvim-telescope/telescope-project.nvim',
    lazy = true,
    config = function()
      require('telescope').load_extension('project')
    end,
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    lazy = true,
    config = function()
      require('telescope').load_extension('ui-select')
    end,
  },
  {
    'xiyaowong/telescope-emoji.nvim',
    lazy = true,
    keys = {
      { '<leader>fe', '<esc><cmd>Telescope emoji<cr>', desc = 'Emoji' },
    },
    config = function()
      require('telescope').load_extension('emoji')
    end,
  },
  {
    'ghassan0/telescope-glyph.nvim',
    lazy = true,
    keys = {
      { '<leader>fG', '<esc><cmd>Telescope glyph<cr>', desc = 'Icon' },
    },
    config = function()
      require('telescope').load_extension('glyph')
    end,
  },
  {
    'tsakirist/telescope-lazy.nvim',
    lazy = true,
    config = function()
      require('telescope').load_extension('lazy')
    end,
  },
  {
    lazy = true,
    'benfowler/telescope-luasnip.nvim',
    config = function()
      require('telescope').load_extension('luasnip')
    end,
  },
  {
    'barrett-ruth/telescope-http.nvim',
    dependencies = {
      'savq/paq-nvim',
    },
    lazy = true,
    config = function()
      require('telescope').load_extension('http')
    end,
  },
  {
    'olacin/telescope-cc.nvim',
    lazy = true,
    config = function()
      require('telescope').load_extension('cc')
    end,
  },
  {
    'ahmedkhalf/project.nvim',
    lazy = true,
    config = function()
      require('telescope').extensions.projects.projects({})
    end,
  },
  {
    'paopaol/telescope-git-diffs.nvim',
    lazy = true,
    config = function()
      require('telescope').load_extension('git_diffs')
    end,
  },
  {
    'LinArcX/telescope-ports.nvim',
    lazy = true,
    config = function()
      require('telescope').load_extension('ports')
    end,
  },
  {
    'lpoto/telescope-tasks.nvim',
    lazy = true,
    config = function()
      require('telescope').load_extension('tasks')
    end,
  },
  {
    'debugloop/telescope-undo.nvim',
    lazy = true,
    keys = {
      { '<leader>fu', '<esc><cmd>Telescope undo_list<cr>', desc = 'Undo List' },
    },
    config = function()
      require('telescope').load_extension('undo')
    end,
  },
  {
    'aznhe21/actions-preview.nvim',
    lazy = true,
    keys = {
      { '<leader>fa', "<esc><cmd>lua require('actions-preview').code_actions<cr>", desc = 'Code Actions' },
    },
    config = function()
      require('telescope').load_extension('actions-preview')
    end,
  },
  {
    'dawsers/telescope-file-history.nvim',
    lazy = true,
    config = function()
      require('telescope').load_extension('file_history')
    end,
  },
  {
    'olacin/telescope-gitmoji.nvim',
    lazy = true,
    keys = {
      { '<leader>fE', '<esc><cmd>Telescope gitmoji<cr>', desc = 'Gitmoji' },
    },
    config = function()
      require('telescope').load_extension('gitmoji')
    end,
  },
  {
    'Shatur/neovim-session-manager',
    lazy = true,
    config = function()
      require('telescope').load_extension('session_manager')
    end,
  },
  {
    'ryanmsnyder/toggleterm-manager.nvim',
    lazy = true,
    cmd = 'Telescope toggleterm_manager',
    config = true,
  },
  {
    'mrjones2014/legendary.nvim',
    version = 'v2.1.0',
    enabled = false,
    lazy = false,
    priority = 10000,
    opts = {
      lazy_nvim = {
        auto_register = true,
      },
      which_key = {
        auto_register = true,
      },
    },
  },
}
