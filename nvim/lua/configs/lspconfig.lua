require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "basedpyright", "clangd", "ruff", "ts_ls", "eslint", "gopls" }
vim.lsp.enable(servers)
