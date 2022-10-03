local M = { }
local conf = { }

function M.setup(p_conf)
  conf = vim.tbl_deep_extend("force", conf, p_conf or {})
  print(vim.inspect(conf))
end

return M
