local SymbolKind = vim.lsp.protocol.SymbolKind

return {
  'Wansmer/symbol-usage.nvim',
  event = 'LspAttach', -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
  opts = {
    hl = { link = 'LspCodeLens' },
    kinds = {
      SymbolKind.Function,
      SymbolKind.Method,
      SymbolKind.Interface,
      SymbolKind.Property,
      SymbolKind.Variable,
      SymbolKind.Enum,
      SymbolKind.Constant,
      SymbolKind.Field,
      SymbolKind.Variable,
      SymbolKind.Object,
    },
    vt_position = 'end_of_line',
  },
}
