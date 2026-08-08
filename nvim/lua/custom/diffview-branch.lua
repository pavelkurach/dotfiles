local M = {}

function M.open_vs_branch()
  local branches = vim.fn.systemlist("git for-each-ref --format='%(refname:short)' refs/heads/")
  if vim.v.shell_error ~= 0 or #branches == 0 then
    vim.notify("No branches found (is this a git repo?)", vim.log.levels.ERROR)
    return
  end

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local themes = require("telescope.themes")

  pickers.new(themes.get_dropdown({}), {
    prompt_title = "Compare against branch",
    finder = finders.new_table({ results = branches }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if selection then
          vim.cmd("DiffviewOpen " .. selection[1] .. "...HEAD")
        end
      end)
      return true
    end,
  }):find()
end

return M
