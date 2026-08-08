local M = {}

local function in_range(line, col, range)
  local sl, sc = range.start.line, range.start.character
  local el, ec = range['end'].line, range['end'].character
  if line < sl or line > el then return false end
  if line == sl and col < sc then return false end
  if line == el and col > ec then return false end
  return true
end

local function find_enclosing(symbols, line, col)
  for _, sym in ipairs(symbols) do
    local range = sym.range or (sym.location and sym.location.range)
    if range and in_range(line, col, range) then
      if sym.children and #sym.children > 0 then
        local inner = find_enclosing(sym.children, line, col)
        if inner then return inner end
      end
      return sym
    end
  end
  return nil
end

function M.yank_symbol()
  local path = vim.fn.expand('%:.')
  local line = vim.fn.line('.')
  local symbol_name = vim.fn.expand('<cword>')
  local result_str = string.format('%s:%d:%s', path, line, symbol_name)
  vim.fn.setreg('+', result_str)
  vim.notify('Copied: ' .. result_str)
end

function M.yank_enclosing()
  local path = vim.fn.expand('%:.')
  local line = vim.fn.line('.')
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor[1] - 1, cursor[2]

  local symbol_name = nil
  local params = { textDocument = vim.lsp.util.make_text_document_params() }
  local ok, result = pcall(vim.lsp.buf_request_sync, 0, 'textDocument/documentSymbol', params, 1000)
  if ok and result then
    for _, res in pairs(result) do
      if res.result then
        local sym = find_enclosing(res.result, row, col)
        if sym then
          symbol_name = sym.name
          break
        end
      end
    end
  end

  if not symbol_name then
    vim.notify('No enclosing symbol found', vim.log.levels.WARN)
    return
  end

  local result_str = string.format('%s:%d:%s', path, line, symbol_name)
  vim.fn.setreg('+', result_str)
  vim.notify('Copied: ' .. result_str)
end

return M
