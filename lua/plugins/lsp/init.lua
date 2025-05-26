local helpers = require('fearphage.helpers')
local user_config = require('fearphage.user-config')

return {
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = {
      'rafamadriz/friendly-snippets',
      'giuxtaposition/blink-cmp-copilot',
    },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = 'default' },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = false } },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = {
          'lazydev',
          'lsp',
          'path',
          'snippets',
          'buffer',
          'copilot',
        },
        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-cmp-copilot',
            score_offset = 100,
            async = true,
          },
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
  },
}
-- return {
--   {
--     'neovim/nvim-lspconfig',
--     event = 'BufReadPre',
--     dependencies = {
--       'mason.nvim',
--       'williamboman/mason-lspconfig.nvim',
--       'hrsh7th/cmp-nvim-lsp',
--       {
--         'mrcjkb/rustaceanvim',
--         version = '^4', -- Recommended
--         lazy = false, -- This plugin is already lazy
--       },
--     },
--     opts = {
--       servers = user_config.lsp_servers,
--     },
--     setup = {},
--     config = function(plugin, opts)
--       vim.diagnostic.config({
--         underline = true,
--         virtual_text = {
--           source = 'if_many',
--           spacing = 3,
--           prefix = '←',
--         },
--         virtual_lines = false,
--         signs = true,
--         severity_sort = true,
--         update_in_insert = false,
--       })
--       -- set diagnostic signs?
--
--       helpers.on_attach(function(client, buffer)
--         require('fearphage.lsp.format').on_attach(client, buffer)
--         require('fearphage.lsp.keymaps').on_attach(client, buffer)
--
--         if client.name == 'tsserver' or client.name == 'ts_ls' then
--           client.server_capabilities.documentFormattingProvider = false
--         elseif client.name == 'gopls' and not client.server_capabilities.semanticTokensProvider then
--           local semantic = client.config.capabilities.textDocument.semanticTokens
--           client.server_capabilities.semanticTokensProvider = {
--             full = true,
--             legend = {
--               tokenModifiers = semantic.tokenModifiers,
--               tokenTypes = semantic.tokenTypes,
--             },
--             range = true,
--           }
--         end
--       end)
--
--       --TODO:fixme
--       -- require("lazyvim.util").on_attach(function(client, buffer)
--       --   if client.supports_method("textDocument/inlayHint") then
--       --     vim.lsp.inlay_hint(buffer)
--       --   end
--       -- end)
--
--       local servers = plugin.opts.servers
--       local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
--
--       require('mason-lspconfig').setup({ ensure_installed = vim.tbl_keys(servers) })
--       require('mason-lspconfig').setup_handlers({
--         function(server)
--           if server == 'tsserver' then
--             server = 'ts_ls'
--           end
--           local server_opts = servers[server] or {}
--           server_opts.capabilities = capabilities
--           if opts.setup[server] then
--             if opts.setup[server](server, server_opts) then
--               return
--             end
--           elseif opts.setup['*'] then
--             if opts.setup['*'](server, server_opts) then
--               return
--             end
--           end
--           require('lspconfig')[server].setup(server_opts)
--         end,
--       })
--     end,
--   },
-- }
