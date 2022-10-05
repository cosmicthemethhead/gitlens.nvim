local settings = require "gitlens.settings"
local virt_txt = require "gitlens.ui.virtual_text"
local git = require "gitlens.api.git"

local M = { }

--- @param config GitlensSettings?
function M.setup(config)
  if config then
    settings.set(config)
  end

  local username = git.get_username()

  vim.api.nvim_create_autocmd("CursorMoved", {
    callback = function()
      -- HACK: checks on every cursor movement
      for _, v in ipairs(settings.current.disabled_filetypes) do
        if vim.bo.filetype == v then return end
      end

      virt_txt.create_virtual_text(git.get_blame(
        vim.fn.expand("%"),
        vim.api.nvim_win_get_cursor(0),
        username
      ))
    end
  })
end

return M
