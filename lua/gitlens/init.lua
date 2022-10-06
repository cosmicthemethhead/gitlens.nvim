local settings = require "gitlens.settings"
local virt_txt = require "gitlens.ui.virtual_text"
local git = require "gitlens.api.git"

local api = vim.api
local M = { }

local username = git.get_username()

function M.enable()
  api.nvim_create_augroup("GitlensBlame", { })
  api.nvim_create_autocmd("CursorMoved", {
    group = "GitlensBlame",
    callback = function()
      -- HACK: checks on every cursor movement
      for _, v in ipairs(settings.current.disabled_filetypes) do
        if vim.bo.filetype == v then return end
      end

      virt_txt.create_virtual_text(git.get_blame(
        vim.fn.expand("%"),
        api.nvim_win_get_cursor(0),
        username
      ))
    end,
  })
end

function M.disable()
  api.nvim_buf_clear_namespace(0, 9, 0, -1)
  api.nvim_del_augroup_by_name("GitlensBlame")
end

--- @param config GitlensSettings?
function M.setup(config)
  if config then
    settings.set(config)
  end

  M.enable()
end

return M
