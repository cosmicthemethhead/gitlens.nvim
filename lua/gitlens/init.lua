local settings = require "gitlens.settings"
local virt_txt = require "gitlens.ui.virtual_text"

local M = { }

--- @param config GitlensSettings?
function M.setup(config)
  if config then
    settings.set(config)
  end

  -- HACK: checks on every cursor movement
  vim.api.nvim_create_autocmd("CursorMoved", {
    callback = function()
      for _, v in ipairs(settings.current.disabled_filetypes) do
        if vim.bo.filetype == v then return end
      end

      virt_txt.create_virtual_text("Hello, World!")
    end
  })
end

return M
