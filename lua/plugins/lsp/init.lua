return {
  {
    'folke/neodev.nvim',
    opts = {
      library = {
        plugins = { 'nvim-treesitter', 'plenary.nvim', 'telescope.nvim', 'neotest' },
        types = true,
      },
    },
    config = true,
  },
  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    dependencies = {
      { 'neodev.nvim' },
      { 'mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'hrsh7th/cmp-nvim-lsp' },
      -- { 'rust-tools.nvim' },
    },
    opts = {
      servers = {
        bashls = {},
        cssls = {},
        dockerls = {},
        gopls = {
          cmd = { 'gopls', '-remote.debug=:0' },
          filetypes = { 'go', 'gomod', 'gohtmltmpl', 'gosum', 'gotexttmpl', 'gotmpl', 'gowork' },
          settings = {
            gopls = {
              analyses = {
                ST1003 = true,
                fieldalignment = true,
                nilness = true,
                nonewvars = true,
                shadow = true,
                undeclaredname = true,
                unreachable = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              completeUnimported = true,
              usePlaceholders = true,
            },
          },
        },
        -- groovyls = {}, -- requires Java :'('
        html = {},
        jsonls = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = {
                -- Fix Undefined global 'vim'
                globals = { 'vim' },
              },
              hint = { enable = true },
              telemetry = { enable = false },
              workspace = {
                checkThirdParty = false,
              },
            },
          },
        },
        nil_ls = {}, -- nix
        pyright = {},
        remark_ls = {}, -- markdown
        -- rust-tools configures this
        -- rust_analyzer = {},
        svelte = {},
        tailwindcss = {},
        terraformls = {
          filetypes = { 'tf', 'terraform' },
        },
        texlab = {
          settings = {
            latex = {
              build = {
                executable = 'pdflatex',
                onSave = true,
              },
            },
          },
        },
        tsserver = {
          settings = {
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
        vimls = {},
        vuels = {},
        yamlls = {},
      },
    },
    setup = {},
    config = function(plugin, opts)
      vim.diagnostic.config({
        underline = true,
        virtual_text = {
          source = 'if_many',
          spacing = 3,
          prefix = '←',
        },
        virtual_lines = false,
        signs = true,
        severity_sort = true,
        update_in_insert = false,
      })
      -- set diagnostic signs?

      require('lazyvim.util').lsp.on_attach(function(client, buffer)
        require('cwebster.plugins.lsp.format').on_attach(client, buffer)
        require('cwebster.plugins.lsp.keymaps').on_attach(client, buffer)

        if client.name == 'tsserver' then
          client.server_capabilities.documentFormattingProvider = false
        elseif client.name == 'gopls' and not client.server_capabilities.semanticTokensProvider then
          local semantic = client.config.capabilities.textDocument.semanticTokens
          client.server_capabilities.semanticTokensProvider = {
            full = true,
            legend = { tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes },
            range = true,
          }
        end
      end)

      --TODO:fixme
      -- require("lazyvim.util").on_attach(function(client, buffer)
      --   if client.supports_method("textDocument/inlayHint") then
      --     vim.lsp.inlay_hint(buffer)
      --   end
      -- end)

      local servers = plugin.opts.servers
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

      require('mason-lspconfig').setup({ ensure_installed = vim.tbl_keys(servers) })
      require('mason-lspconfig').setup_handlers({
        function(server)
          local server_opts = servers[server] or {}
          server_opts.capabilities = capabilities
          if opts.setup[server] then
            if opts.setup[server](server, server_opts) then
              return
            end
          elseif opts.setup['*'] then
            if opts.setup['*'](server, server_opts) then
              return
            end
          end
          require('lspconfig')[server].setup(server_opts)
        end,
      })
    end,
  },
}
