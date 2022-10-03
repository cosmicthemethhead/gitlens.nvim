local M = { }
local conf = { }

function M.setup(p_conf)
  conf = vim.tbl_deep_extend("force", conf, p_conf or {})
  print(vim.inspect(conf))
end

vim.api.nvim_create_autocmd("CursorMoved", {
  callback = function()
    require("gitlens.renderer.virtual_text").x("Hello, World!")
  end
})

return M
