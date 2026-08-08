local M = {}

M.config = function()
  local dap = require "dap"
  local codelldb = vim.fn.expand "$MASON/packages/codelldb/codelldb"

  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = codelldb,
      args = { "--port", "${port}" },
    },
  }

  dap.configurations.c = {
    {
      name = "Debug an Executable",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
  }
  dap.configurations.cpp = dap.configurations.c
end

return M
