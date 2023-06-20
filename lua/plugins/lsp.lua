return {
  'VonHeikemen/lsp-zero.nvim',
  event = "BufReadPre",
  dependencies = {
    -- LSP Support
    { 'neovim/nvim-lspconfig' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },

    -- Autocompletion
    {
      'hrsh7th/nvim-cmp',
      dependencies = {
        'L3MON4D3/LuaSnip',
        'rafamadriz/friendly-snippets',
      },
      opts = {
        snippet = {
          expand = function(args)
            require'luasnip'.lsp_expand(args.body)
          end
        },

        sources = {
          { name = 'luasnip' },
          -- more sources
        },
      },
    },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lua' },

    -- Snippets
    {
      'L3MON4D3/LuaSnip',
      build = 'make install_jsregexp'
    },
    { 'rafamadriz/friendly-snippets' },
  },
  config = function()
    local lsp = require("lsp-zero")

    lsp.preset("recommended")

    lsp.ensure_installed({
      'bashls',
      'dockerls',
      'eslint',
      'jsonls',
      'lua_ls',
      'marksman', -- markdown
      'rust_analyzer',
      'tsserver',
      --'vim-language-server',
      'yamlls',
    })

    -- Fix Undefined global 'vim'
    lsp.configure('lua_ls', {
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' }
          }
        }
      }
    })

    -- disable key ordering
    lsp.configure('yamlls', {
      settings = {
        yaml = {
          format = {
            printWidth = 100,
          },
          keyOrdering = false,
          mapKeyOrder = false,
        },
      },
    })


    local cmp = require('cmp')
    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    local cmp_mappings = lsp.defaults.cmp_mappings({
      ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
      ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
      ['<C-y>'] = cmp.mapping.confirm({ select = true }),
      ["<C-Space>"] = cmp.mapping.complete(),
    })

    -- disable completion with tab
    -- this helps with copilot setup
    -- cmp_mappings['<Tab>'] = nil
    -- cmp_mappings['<S-Tab>'] = nil

    lsp.setup_nvim_cmp({
      mapping = cmp_mappings
    })

    lsp.set_preferences({
      suggest_lsp_servers = false,
      sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
      }
    })

    lsp.on_attach(function(_, bufnr)
      local opts = { buffer = bufnr, remap = false }

      -- if client.name == "eslint" then
      --   vim.cmd.LspStop('eslint')
      --   return
      -- end

      -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
      vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
      -- deprecated
      -- vim.keymap.set("n", "<leader>e", vim.lsp.diagnostic.show_line_diagnostics, opts)
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
      vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
      vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    end)

    lsp.setup()

    vim.diagnostic.config({
      float = {
        border = 'rounded',
        format = function(diagnostic)
          if diagnostic.source == 'eslint' then
            return string.format(
              '%s [%s]',
              diagnostic.message,
              -- rule name
              diagnostic.user_data.lsp.code
            )
          end

          return string.format('%s [%s]', diagnostic.message, diagnostic.source)
        end,
        severity_sort = true,
        close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
        max_width = 80,
      },
      severity_sort = true,
      virtual_text = {
        prefix = '●',
      },
    })
  end,
}
