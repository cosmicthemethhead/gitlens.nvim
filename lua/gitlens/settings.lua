local M = { }

--- @class GitlensSettings
local DEFAULT_SETTINGS = {
  DEFAULT_SETTINGS = {
    ui = { logo = '' }
  },
}

M._DEFAULT_SETTINGS = DEFAULT_SETTINGS
M.current = M._DEFAULT_SETTINGS

--- @param opts GitlensSettings
function M.set(opts)
  M.current = vim.tbl_deep_extend("force", M.current, opts or { })
end

return M
