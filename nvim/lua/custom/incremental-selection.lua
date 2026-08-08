-- Incremental selection on the core vim.treesitter API.
-- Replaces the `incremental_selection` module dropped from nvim-treesitter `main`.

local M = {}

-- per-buffer stack of selected nodes; top is the current selection
local selections = {}

local function same_range(a, b)
  local a1, a2, a3, a4 = a:range()
  local b1, b2, b3, b4 = b:range()
  return a1 == b1 and a2 == b2 and a3 == b3 and a4 == b4
end

local function visual_select(node)
  local srow, scol, erow, ecol = node:range()

  -- treesitter end-col is exclusive; ecol == 0 means the range ends at the
  -- start of erow, i.e. the real last char is on the previous line.
  if ecol == 0 then
    erow = erow - 1
    ecol = #(vim.api.nvim_buf_get_lines(0, erow, erow + 1, true)[1] or "")
  end
  local last_col = math.max(ecol - 1, 0)

  if vim.fn.mode():find "[vV\22]" then
    vim.cmd "normal! \27"
  end
  vim.api.nvim_win_set_cursor(0, { srow + 1, scol })
  vim.cmd "normal! v"
  vim.api.nvim_win_set_cursor(0, { erow + 1, last_col })
end

function M.init()
  local ok, parser = pcall(vim.treesitter.get_parser)
  if not ok or not parser then
    return
  end
  parser:parse()
  local node = vim.treesitter.get_node()
  if not node then
    return
  end
  selections[vim.api.nvim_get_current_buf()] = { node }
  visual_select(node)
end

function M.grow()
  local nodes = selections[vim.api.nvim_get_current_buf()]
  if not nodes then
    return M.init()
  end

  local current = nodes[#nodes]
  local parent = current:parent()
  while parent and same_range(parent, current) do
    parent = parent:parent()
  end
  if not parent then
    return
  end

  nodes[#nodes + 1] = parent
  visual_select(parent)
end

function M.shrink()
  local nodes = selections[vim.api.nvim_get_current_buf()]
  if not nodes or #nodes < 2 then
    return
  end

  nodes[#nodes] = nil
  visual_select(nodes[#nodes])
end

return M
