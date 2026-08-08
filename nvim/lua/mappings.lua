require "nvchad.mappings"
local yank_path = require "custom.yank-path"
local yank_symbol_path = require "custom.yank-symbol-path"

local map = vim.keymap.set

map({ "i", "v" }, "jk", "<ESC>")

map({ "n", "i", "v" }, "<C-u>", "<C-u>zz")
map({ "n", "i", "v" }, "<C-d>", "<C-d>zz")

-- Copilot
map("i", "jj", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})
vim.g.copilot_no_tab_map = true
map("i", "<C-L>", "<Plug>(copilot-accept-word)")
map("i", "<C-]", "<Plug>(copilot-next)")
map("i", "<C-[>", "<Plug>(copilot-previous)")

map({ "n", "i", "v" }, "zm", ":ZenMode<CR>", { desc = "Zen Mode" })

-- Debugger
map("n", "<leader>db", ":DapToggleBreakpoint<CR>", { desc = "Toggle Breakpoint" })
map("n", "dac", ":DapContinue<CR>", { desc = "DAP Continue" })
map("n", "din", ":DapStepInto<CR>", { desc = "DAP Step Into" })
map("n", "dou", ":DapStepOut<CR>", { desc = "DAP Step Out" })
map("n", "dov", ":DapStepOver<CR>", { desc = "DAP Step Over" })
map("n", "dat", ":DapTerminate<CR>", { desc = "DAP Terminate" })
map("n", "dut", '<cmd>lua require"dapui".toggle()<CR>', { desc = "DAP Toggle UI" })

-- Diffview
map("n", "<leader>dv", require("custom.diffview-branch").open_vs_branch, { desc = "Diffview Open" })
map("n", "<leader>dvc", ":DiffviewClose<CR>", { desc = "Diffview Close" })

-- Spectre
map("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', {
  desc = "Toggle Spectre",
})
map("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
  desc = "Search current word",
})
map("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
  desc = "Search current word",
})
map("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = "Search on current file",
})

map("n", "<leader>ih", "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>", {
  desc = "Toggle Inlay Hints",
})

-- Incremental selection (treesitter)
local incsel = require "custom.incremental-selection"
map("n", "g;", incsel.init, { desc = "TS init selection" })
map("x", "g;", incsel.grow, { desc = "TS grow selection" })
map("x", "g,", incsel.shrink, { desc = "TS shrink selection" })

-- Treewalker
map("n", "tj", ":Treewalker Down<CR>", { noremap = true })
map("n", "tk", ":Treewalker Up<CR>", { noremap = true })
map("n", "th", ":Treewalker Left<CR>", { noremap = true })
map("n", "tl", ":Treewalker Right<CR>", { noremap = true })

-- Telescope
map("n", "<leader>fr", ":Telescope lsp_references<CR>", { noremap = true, silent = true })
map("n", "<leader>fd", ":Telescope lsp_definitions<CR>", { noremap = true, silent = true })
map("n", "<leader>fi", ":Telescope lsp_implementations<CR>", { noremap = true, silent = true })
map("n", "<leader>ft", ":Telescope lsp_type_definitions<CR>", { noremap = true, silent = true })
map("n", "<leader>ic", ":Telescope lsp_incoming_calls<CR>", { noremap = true, silent = true })
map("n", "<leader>oc", ":Telescope lsp_outgoing_calls<CR>", { noremap = true, silent = true })
map("n", "<leader>tr", ":Telescope resume<CR>", { desc = "Resume Last Telescope" })

-- RustTest
map("n", "<leader>rt", ":RustTest<CR>", { noremap = true, silent = false })
map("n", "<leader>rta", ":RustTest!<CR>", { noremap = true, silent = false })

map("n", "<leader>yy", yank_path.yank_line, { desc = "Yank filepath:line" })
map("v", "<leader>yy", yank_path.yank_range, { desc = "Yank filepath:start:end" })
map("n", "<leader>ys", yank_symbol_path.yank_symbol, { desc = "Yank filepath:line:symbol (cword)" })
map("n", "<leader>ye", yank_symbol_path.yank_enclosing, { desc = "Yank filepath:line:enclosing-symbol" })
