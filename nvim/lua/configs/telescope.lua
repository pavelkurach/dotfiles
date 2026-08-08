dofile(vim.g.base46_cache .. "telescope")

local nvchad_options = function()
  return require "nvchad.configs.telescope"
end

local options = vim.tbl_deep_extend("force", nvchad_options(), {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "-L",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--no-ignore",
      "--glob=!**/.git/*",
    },
  },
  extension_list = {
    "cmdline",
  },
})

return options
