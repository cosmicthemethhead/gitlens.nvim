local M = { }

function M.get_blame(file, line)
  local int_blame = vim.fn.system(string.format("git blame -c -L %d,%d %s", line[1], line[1], file))
  local hash = vim.split(int_blame, "%s")[1]

  local cmd = string.format("git show %s --format='%s'", hash, "%an | %ar | %s")

  local txt = ""
  if hash == '00000000' then
    txt = 'Not Committed Yet'
  else
    txt = vim.fn.system(cmd)
    txt = vim.split(txt, '\n')[1]
    if txt:find("fatal") then
      txt = "Not Committed Yet"
    end
  end

  return txt
end

return M
