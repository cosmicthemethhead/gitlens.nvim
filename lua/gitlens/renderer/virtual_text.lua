local M = { }

function M.x(text)
  vim.api.nvim_buf_clear_namespace(0, 9, 0, -1)

  local line = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_buf_set_extmark(0, 9, line[1] - 1, 0, {
    virt_text = {{ text, "gitlens_blame" }},
  })
end

return M
