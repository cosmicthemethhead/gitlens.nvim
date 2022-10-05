local M = { }

local function git_cmd(cmd)
  local txt = vim.fn.system(cmd)
  txt = vim.split(txt, '\n')[1]
  return txt
end

function M.get_username()
  return git_cmd("git config user.name")
end

function M.get_blame(file, line, int_username)
  -- HACK: every thing before "local txt" should be in the "if hash" if statement
  local int_blame = vim.fn.system(string.format("git blame -c -L %d,%d %s", line[1], line[1], file))
  local hash = vim.split(int_blame, "%s")[1]

  local username = git_cmd(string.format("git show %s ", hash).."--format='%an'")
  if username == int_username then
    username = "You"
  end

  local cmd = string.format("git show %s --format='%s %s'",
    hash, username, "| %ar | %s"
  )

  local txt = ""
  if hash == '00000000' then
    txt = 'Not Committed Yet'
  else
    txt = git_cmd(cmd)
    if txt:find("fatal") then
      txt = "Not Committed Yet"
    end
  end

  return txt
end

return M
