require "nvchad.autocmds"

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local function opts(desc)
      return { buffer = args.buf, desc = "LSP " .. desc }
    end

    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts "Go to type definition")
    vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts "Hover information")

    vim.api.nvim_set_hl(0, "LspInlayHint", { bg = "NONE", fg = "#666666" })
  end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  command = "checktime",
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  callback = function()
    vim.notify("File changed on disk, buffer reloaded", vim.log.levels.WARN)
  end,
})
