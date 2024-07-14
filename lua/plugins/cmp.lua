-- Autocompletion,
--
local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  -- return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match('^%s*$') == nil
end

return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'f3fora/cmp-spell',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
      -- "hrsh7th/cmp-nvim-lsp-signature-help",
      'onsails/lspkind.nvim', -- vs-code like pictograms,
      'rafamadriz/friendly-snippets',
      'rafamadriz/friendly-snippets',
      'saadparwaiz1/cmp_luasnip',
      { 'windwp/nvim-autopairs', opts = { fast_wrap = {} } },
      { 'petertriho/cmp-git', dependencies = 'nvim-lua/plenary.nvim' },
    },
    opts = {},
    config = function()
      local cmp = require('cmp')
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp_select = { behavior = cmp.SelectBehavior.Select }
      local luasnip = require('luasnip')
      local lspkind = require('lspkind')

      require('luasnip.loaders.from_vscode').lazy_load()

      local luasnip_jump_forward = function(fallback)
        if luasnip.jumpable(1) then
          luasnip.jump(1)
        else
          fallback()
        end
      end

      local luasnip_jump_backward = function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end

      cmp.setup({
        -- mapping = cmp_mappings,
        mapping = {
          -- ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select), -- custom adds by Phred
          -- ['<C-j>'] = cmp.mapping.select_next_item(cmp_select), -- custom adds by Phred
          ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
          ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ['<C-f>'] = cmp.mapping(luasnip_jump_forward, { 'i', 's' }),
          ['<C-b>'] = cmp.mapping(luasnip_jump_backward, { 'i', 's' }),
          ['<C-e>'] = cmp.mapping.abort(), -- close completion window
          ['<C-Space>'] = cmp.mapping.complete(), -- show completion suggestions
          ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- scroll up the documentation window
          ['<C-d>'] = cmp.mapping.scroll_docs(4), -- scroll down the documentation window,
          -- new from cweb
          ['<Tab>'] = vim.schedule_wrap(
            function(fallback)
              if cmp.visible() and has_words_before() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              -- elseif has_words_before() then
              --   cmp.complete()
              else
                -- local copilot_keys = vim.fn["copilot#Accept"]()
                -- if copilot_keys ~= "" then
                --   vim.api.nvim_feedkeys(copilot_keys, "i", true)
                -- else
                fallback()
                -- end
              end
            end
            -- { "i", "s" },
          ),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          }),
        },
        enabled = function()
          -- disables in comments
          local context = require('cmp.config.context')
          if vim.api.nvim_get_mode().mode == 'c' then
            return true
          else
            return not context.in_treesitter_capture('comment') and not context.in_syntax_group('Comment')
          end
        end,
        -- preselect = 'none',
        completion = {
          completeopt = 'menu,menuone,noinsert,noselect',
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
          documentation = {
            border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
          },
        },
        formatting = {
          fields = { 'abbr', 'kind', 'menu' },
          format = lspkind.cmp_format({
            maxwidth = 50,
            menu = { -- new from cweb
              nvim_lsp = '(LSP)',
              emoji = '(Emoji)',
              path = '(Path)',
              calc = '(Calc)',
              vsnip = '(Snippet)',
              luasnip = '(Snippet)',
              buffer = '(Buffer)',
              spell = '(Spell)',
              copilot = '(Copilot)',
            },
            ellipsis_char = '...',
            mode = 'symbol',
            symbol_map = { Copilot = '' },
          }),
        },
        sorting = {
          priority_weight = 2,
          comparators = {
            cmp.config.compare.exact,
            -- no copilot yet
            -- (function()
            --   local success, module = pcall(require, 'copilot_cmp.comparators')
            --   return success and module.prioritize or nil
            -- end)(),
            cmp.config.compare.offset,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        sources = {
          { name = 'lazydev', group_index = 0 },
          { name = 'crates', group_index = 1 },
          { name = 'copilot', max_item_count = 3, group_index = 2 },
          { name = 'nvim_lsp', max_item_count = 5, group_index = 2, keyword_length = 3 },
          { name = 'path', max_item_count = 3, group_index = 2 },
          { name = 'luasnip', max_item_count = 5, group_index = 2, keyword_length = 2 },
          { name = 'nvim_lua', max_item_count = 5, group_index = 2 },
          { name = 'buffer', group_index = 3 },
          { name = 'calc', group_index = 3 },
          { name = 'emoji', group_index = 3 },
          { name = 'treesitter', group_index = 3 },
          { name = 'spell', group_index = 3 },
        },
        experimental = {
          ghost_text = true,
        },
      })

      -- cmp.event:on( -- original
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

      -- from cweb
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))

      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' },
        }, {
          { name = 'buffer' },
        }),
      })

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        view = {
          entries = { name = 'wildmenu', separator = '|' },
        },
        sources = {
          { name = 'nvim_lsp_document_symbol' },
        },
        {
          { name = 'buffer' },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        formatting = {
          format = function(_, vim_item)
            vim_item.kind = ''
            vim_item.menu = ''
            return vim_item
          end,
        },
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
      })
    end,
  },
}
