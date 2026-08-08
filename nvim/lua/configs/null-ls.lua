local null_ls = require "null-ls"

local opts = {
  sources = {
    -- python type-checking (formatting handled by conform)
    null_ls.builtins.diagnostics.mypy,
  },
}
return opts
