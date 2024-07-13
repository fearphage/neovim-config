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
