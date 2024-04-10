-- vim.lsp.set_log_level('debug')
-- if vim.fn.has('nvim-0.5.1') == 1 then
--   require('vim.lsp.log').set_format_func(vim.inspect)
-- end
return {
  'VonHeikemen/lsp-zero.nvim',
  event = 'BufReadPre',
  dependencies = {
    -- LSP Support
    { 'neovim/nvim-lspconfig' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
  },
  config = function()
    local lsp = require('lsp-zero')
    local lspconfig = require('lspconfig')

    lsp.preset('recommended')

    lsp.ensure_installed({
      'bashls',
      'cssls',
      'dockerls',
      'eslint',
      'gopls',
      -- 'groovyls', -- requires Java :'('
      'jsonls',
      'lua_ls',
      'remark_ls', -- markdown
      'rust_analyzer',
      'tailwindcss',
      'terraformls',
      'tsserver',
      --'vim-language-server',
      'yamlls',
    })

    lsp.configure('gopls', {
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
    })

    -- trying to use groovyls without installing java
    -- lsp.configure('groovyls', {
    --   cmd = { 'docker', 'run', '--rm', '--interactive', 'justin2004/groovy-language-server_box' },
    --   cmd = { 'docker', 'run', '--rm', '--interactive', 'phred.local/groovy-language-server' },
    --   enabled = false,
    --   filetypes = { 'groovy', 'Jenkinsfile' },
    -- })

    require('lspconfig.configs').docker_groovy_lsp = {
      default_config = {
        name = 'docker-groovy-language-server',
        cmd = { 'docker', 'container', 'run', '--rm', '--interactive', 'phred.local/groovy-language-server' },
        filetypes = { 'groovy', 'Jenkinsfile' },
        -- root_dir = lspconfig.util.root_pattern('Jenkinsfile', 'build.gradle', 'settings.gradle', '.git')
        root_dir = function(fname)
          -- return lspconfig.util.root_pattern('build.gradle', 'settings.gradle', 'gradlew')(fname)
          --   or lspconfig.util.path.dirname(fname)
          return lspconfig.util.path.dirname(fname)
        end,
      },
    }

    require('lspconfig.configs').npm_groovy_lint = {
      default_config = {
        name = 'npm-groovy-list-server',
        cmd = { 'npm-groovy-lint' },
        filetypes = { 'groovy', 'Jenkinsfile' },
        root_dir = function(fname)
          return lspconfig.util.path.dirname(fname)
        end,
      },
    }

    -- lspconfig.docker_groovy_lsp.setup({
    --   settings = {
    --     groovy = {},
    --   },
    --   name = 'docker-groovy-language-server',
    --   cmd = { 'docker', 'run', '--rm', '--interactive', 'phred.local/groovy-language-server' },
    --   filetypes = { 'groovy', 'Jenkinsfile' },
    --   root_dir = require('lspconfig.util').root_pattern('Jenkinsfile', '.git'),
    -- })

    -- lsp.configure('lua_ls', {
    --   settings = {
    --     Lua = {
    --       diagnostics = {
    --         -- Fix Undefined global 'vim'
    --         globals = { 'vim' },
    --       },
    --       workspace = {
    --         -- https://github.com/LunarVim/LunarVim/issues/4049
    --         checkThirdParty = false,
    --         hint = { enabled = true },
    --       },
    --     },
    --   },
    -- })

    -- disable key ordering
    -- lsp.configure('yamlls', {
    --   settings = {
    --     yaml = {
    --       format = {
    --         printWidth = 100,
    --       },
    --       keyOrdering = false,
    --       mapKeyOrder = false,
    --     },
    --   },
    -- })

    -- local cmp = require('cmp')
    -- local cmp_action = require('lsp-zero').cmp_action()
    -- local luasnip = require('luasnip')
    -- require('luasnip.loaders.from_vscode').lazy_load()
    -- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    -- local handlers = require('nvim-autopairs.completion.handlers')
    -- cmp.event:on(
    --   'confirm_done',
    --   cmp_autopairs.on_confirm_done({
    --     filetypes = {
    --       ['*'] = {
    --         ['('] = {
    --           kind = {
    --             cmp.lsp.CompletionItemKind.Function,
    --             cmp.lsp.CompletionItemKind.Method,
    --           },
    --           handler = handlers['*'],
    --         },
    --       },
    --     },
    --   })
    -- )
    --
    -- local cmp_select = { behavior = cmp.SelectBehavior.Select }
    -- local cmp_mappings = lsp.defaults.cmp_mappings({
    --   ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select), -- custom adds by Phred
    --   ['<C-j>'] = cmp.mapping.select_next_item(cmp_select), -- custom adds by Phred
    --   ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    --   ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    --   ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    --   ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    --   ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    --   ['<C-e>'] = cmp.mapping.abort(), -- close completion window
    --   ['<C-Space>'] = cmp.mapping.complete(), -- show completion suggestions
    --   ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- scroll up the documentation window
    --   ['<C-d>'] = cmp.mapping.scroll_docs(4), -- scroll down the documentation window
    -- })

    -- disable completion with tab
    -- this helps with copilot setup
    -- cmp_mappings['<Tab>'] = nil
    -- cmp_mappings['<S-Tab>'] = nil

    -- lsp.setup_nvim_cmp({
    --   mapping = cmp_mappings,
    --   enabled = function()
    --     -- disables in comments
    --     local context = require('cmp.config.context')
    --     if vim.api.nvim_get_mode().mode == 'c' then
    --       return true
    --     else
    --       return not context.in_treesitter_capture('comment') and not context.in_syntax_group('Comment')
    --     end
    --   end,
    --   preselect = 'none',
    --   completion = {
    --     completeopt = 'menu,menuone,noinsert,noselect',
    --   },
    --   snippet = {
    --     expand = function(args)
    --       luasnip.lsp_expand(args.body)
    --     end,
    --   },
    --   window = {
    --     completion = cmp.config.window.bordered(),
    --     documentation = cmp.config.window.bordered(),
    --   },
    --   formatting = {
    --     fields = { 'abbr', 'kind', 'menu' },
    --     format = require('lspkind').cmp_format({
    --       maxwidth = 50,
    --       ellipsis_char = '...',
    --       mode = 'symbol',
    --       symbol_map = { Copilot = '' },
    --     }),
    --   },
    --   sorting = {
    --     priority_weight = 2,
    --     comparators = {
    --       cmp.config.compare.exact,
    --       -- no copilot yet
    --       -- (function()
    --       --   local success, module = pcall(require, 'copilot_cmp.comparators')
    --       --   return success and module.prioritize or nil
    --       -- end)(),
    --       cmp.config.compare.offset,
    --       cmp.config.compare.score,
    --       cmp.config.compare.recently_used,
    --       cmp.config.compare.locality,
    --       cmp.config.compare.kind,
    --       cmp.config.compare.sort_text,
    --       cmp.config.compare.length,
    --       cmp.config.compare.order,
    --     },
    --   },
    -- })

    lsp.set_preferences({
      suggest_lsp_servers = false,
      sign_icons = {
        error = '✘',
        warn = '▲',
        hint = '⚑',
        info = '»',
      },
    })

    lsp.on_attach(function(client, bufnr)
      local opts = { buffer = bufnr, remap = false }

      if client.name == 'gopls' and not client.server_capabilities.semanticTokensProvider then
        local semantic = client.config.capabilities.textDocument.semanticTokens
        client.server_capabilities.semanticTokensProvider = {
          full = true,
          legend = { tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes },
          range = true,
        }
      end

      -- if client.name == 'eslint' then
      --   vim.cmd.LspStop('eslint')
      --   return
      -- end

      -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
      vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
      -- deprecated
      -- vim.keymap.set('n', '<leader>e', vim.lsp.diagnostic.show_line_diagnostics, opts)
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
      vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
      -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, opts)
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
