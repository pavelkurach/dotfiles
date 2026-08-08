local on_attach = function(_, bufnr)
  vim.keymap.set("n", "<leader>ca", function()
    vim.cmd.RustLsp "codeAction" -- supports rust-analyzer's grouping
  end, { silent = true, buffer = bufnr })

  vim.keymap.set(
    "n",
    "gh", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
    function()
      vim.cmd.RustLsp { "hover", "actions" }
    end,
    { silent = true, buffer = bufnr }
  )

  vim.keymap.set("n", "<leader>dpr", "<CMD>RustLsp debuggables<CR>", { desc = "Test Method" })
end

local dap = function()
  local extension_path = vim.fn.expand "$MASON/packages/codelldb/extension/"
  local codelldb_path = extension_path .. "adapter/codelldb"
  local liblldb_path = extension_path .. "lldb/lib/liblldb"
  local this_os = vim.uv.os_uname().sysname .. ""

  liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")

  local cfg = require "rustaceanvim.config"
  return {
    adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
  }
end

local M = {}

M.config = function()
  vim.g.rustaceanvim = {
    server = {
      on_attach = on_attach,
    },
    dap = dap(),
  }
end

return M
