local user_config = require('fearphage.user-config')
-- local slow_format_filetypes = {}

-- Formatting
return {
  'stevearc/conform.nvim',
  keys = {
    {
      -- Customize or remove this keymap to your liking
      '<leader>af',
      function()
        require('conform').format({ async = true, lsp_fallback = true })
      end,
      mode = '',
      desc = 'Format buffer',
    },
  },
  opts = {
    -- stylua: ignore
    formatters = {
      biome = {
        prepend_args = { 'format' , '--arrow-parentheses', 'as-needed', '--indent-style', 'space', '--javascript-formatter-quote-style', 'single', '--semicolons', 'always', '--use-editorconfig', 'true' }
      },
      markdownlint = {
        -- prepend_args = { '--config', vim.g.linterConfigs .. '/markdownlint.yaml' },
      },
      npm_groovy_lint = {
        command = "npm-groovy-lint",
        args = { '--failon', 'none', '--format', '$FILENAME'},
        inherit = false,
        stdin = false,
      },
      prettier = {
        prepend_args = { '--arrow-parens', 'avoid', '--single-quote' },
      },
      ruff = {
        args_ = {
          'format',
          '--config',
          'format.quote-style = "single"',
          '--force-exclude',
          '--stdin-filename',
          '$FILENAME',
          '-',
        },
      },
      shfmt = {
        prepend_args = {
          '--case-indent',
          '--indent', '2',
          -- '--keep-padding',
          '--space-redirects'
        },
      },
      stylua = {
        prepend_args = { '--indent-type', 'Spaces', '--indent-width', '2', '--quote-style', 'AutoPreferSingle' },
      },
    },
    formatters_by_ft = user_config.formatters_by_ft,
  },
}
