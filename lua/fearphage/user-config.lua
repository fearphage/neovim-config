-- use a user/user_config.lua file to provide your own configuration

local M = {}

-- add any null-ls sources you want here
M.setup_sources = function(b)
  return {
    b.formatting.autopep8,
    b.code_actions.gitsigns,
  }
end

-- add null_ls sources to auto-install
M.null_ls_ensure_installed = {
  'stylua',
  'jq',
}

-- add servers to be used for auto formatting here
M.formatting_servers = {
  ['rust_analyzer'] = { 'rust' },
  ['lua_ls'] = { 'lua' },
  ['null_ls'] = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
}

-- options you put here will override or add on to the default options
M.options = {
  opt = {
    confirm = false,
  },
}

-- Set any to false that you want disabled in here.
-- Default value is true if left blank
M.autocommands = {
  inlay_hints = true,
  alpha_folding = true,
  treesitter_folds = true,
  trailing_whitespace = true,
  remember_file_state = true,
  session_saved_notification = true,
  format_on_autosave = true,
  css_colorizer = true,
  activate_neotree = true,
}

-- set to false to disable plugins
-- Default value is true if left blank
M.enable_plugins = {
  aerial = true,
  alpha = true,
  autopairs = true,
  autosave = true,
  bufferline = true,
  cmp = true,
  colorizer = true,
  comment = true,
  copilot = true,
  dap = true,
  dressing = true,
  gitsigns = true,
  hop = true,
  indent_blankline = true,
  inlay_hints = true,
  lsp_zero = true,
  lualine = true,
  neodev = true,
  neoscroll = true,
  neotree = true,
  noice = true,
  notify = true,
  null_ls = true,
  onedark = true,
  project = true,
  scope = true,
  session_manager = true,
  surround = true,
  telescope = true,
  toggleterm = true,
  treesitter = true,
  trouble = true,
  twilight = true,
  ufo = true,
  whichkey = true,
  zen = true,
}

--stylua: ignore
M.formatters_by_ft = {
  ["*"] = { "codespell" },
  ["_"] = { "trim_whitespace", "trim_newlines", "squeeze_blanks" },
  -- bib = { "trim_whitespace", "bibtex-tidy" },
  css = { "stylelint", "prettier" },
  groovy = { "npm_groovy_lint" },
  html = { "prettier" },
  javascript = { "biome" },
  json = { "biome" },
  jsonc = { "biome" },
  lua = { "stylua" },
  markdown = { "markdown-toc", "markdownlint", --[[ "injected", ]] },
  nix = { "alejandra" },
  python = { "isort", "black" },
  sh = { "shellcheck", "shfmt" },
  typescript = { "biome" },
  yaml = { "prettier" },
}

M.lsp_servers = {
  bashls = {},
  cssls = {},
  dockerls = {},
  gleam = {
    cmd = { 'gleam', 'lsp' },
    filetypes = { 'gleam' },
    root_dir = require('lspconfig.util').root_pattern('gleam.toml', '.git'),
  },
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
  -- nil_ls = {}, -- nix
  pyright = {},
  -- remark_ls = {}, -- markdown
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
}

return M
