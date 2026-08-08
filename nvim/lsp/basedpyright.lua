return {
  filetypes = { "python" },
  settings = {
    basedpyright = {
      disableOrganizeImports = true, -- Using Ruff
      analysis = {
        typeCheckingMode = "strict",
      },
    },
  },
}
