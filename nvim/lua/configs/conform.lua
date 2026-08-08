local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    toml = { "taplo" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    asm = { "asmfmt" },
    go = { "goimports", "gofumpt" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
