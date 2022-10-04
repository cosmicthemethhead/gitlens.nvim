local settings = require "gitlens.settings"
local virt_txt = require "gitlens.renderer.virtual_text"

local M = { }

---@param config GitlensSettings?
function M.setup(config)
  if config then
    settings.set(config)
  end

  vim.api.nvim_create_autocmd("CursorMoved", {
    callback = function()
      virt_txt.create_virtual_text("Hello, World!")
    end
  })
end

return M
