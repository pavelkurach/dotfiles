local M = {}

function M.yank_line()
  local path = vim.fn.expand('%:.')
  local line = vim.fn.line('.')
  local result = string.format('%s:%d', path, line)
  vim.fn.setreg('+', result)
  vim.notify('Copied: ' .. result)
end

function M.yank_range()
  local path = vim.fn.expand('%:.')
  local start_line = vim.fn.line('v')
  local end_line = vim.fn.line('.')
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end
  local result = string.format('%s:%d:%d', path, start_line, end_line)
  vim.fn.setreg('+', result)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
  vim.notify('Copied: ' .. result)
end

return M
