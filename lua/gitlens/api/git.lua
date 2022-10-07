local M = { }
local settings = require "gitlens.settings"

local function git_cmd(cmd)
  local txt = vim.fn.system(cmd)
  txt = vim.split(txt, '\n')[1]
  return txt
end

function M.get_username()
  return git_cmd("git config user.name")
end

function M.get_blame(file, line, int_username)
  local blame = ""

  local int_blame = vim.fn.system(string.format("git blame -c -L %d,%d %s", line[1], line[1], file))
  local hash = vim.split(int_blame, "%s")[1]

  if hash == '00000000' then
    blame = 'Not Committed Yet'
  else
    -- get the user and check if it's equivalent to the internal on, change it to a user difined one
    local username = git_cmd(string.format("git show %s ", hash).."--format='%an'")
    if username == int_username then
      username = settings.current.ui.username
    end

    local cmd = string.format("git show %s --format='%s %s'",
      hash, username, "| %ar | %s"
    )

    blame = git_cmd(cmd)
    if blame:find("fatal") then
      blame = "ERR"
    end
  end

  return blame
end

return M
