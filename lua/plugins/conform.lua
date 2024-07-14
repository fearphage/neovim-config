local user_config = require('fearphage.user-config')
local slow_format_filetypes = {}

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
    --[[
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      if slow_format_filetypes[vim.bo[bufnr].filetype] then
        return
      end
      local function on_format(err)
        if err and err:match('timeout$') then
          slow_format_filetypes[vim.bo[bufnr].filetype] = true
        end
      end

      return { timeout_ms = 200, lsp_fallback = true }, on_format
    end,
    format_after_save = function(bufnr)
      if not slow_format_filetypes[vim.bo[bufnr].filetype] then
        return
      end
      return { lsp_fallback = true }
    end,
    ]]--
    -- stylua: ignore
    formatters = {
      biome = {
        prepend_args = { 'format' , '--arrow-parentheses', 'as-needed', '--indent-style', 'space', '--semicolons', 'always', '--quote-style', 'single' }
      },
      npm_groovy_lint = {
        command = "npm-groovy-lint",
        args = { '--failon', 'none', '--format', '$FILENAME'},
        inherit = false,
        stdin = false,
      },
      prettier = {
        prepend_args = { '--arrow-parens', 'avoid', '--jsx-single-quote', '--single-quote' },
      },
      shfmt = {
        prepend_args = { '--case-indent', '--indent', '2', '--keep-padding', '--space-redirects' },
      },
      stylua = {
        prepend_args = { '--indent-type', 'Spaces', '--indent-width', '2', '--quote-style', 'AutoPreferSingle' },
      },
    },
    formatters_by_ft = user_config.formatters_by_ft,
  },
}
