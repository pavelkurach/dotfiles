local nvchad_opts = function()
  return require "nvchad.configs.nvimtree"
end

local opts = vim.tbl_deep_extend("force", nvchad_opts(), {
  view = { adaptive_size = true },
})

return opts
