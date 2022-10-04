local gitlens = require("gitlens")

gitlens.setup {
  ui = {
    logo = ''
  },

  disabled_filetypes = {
    "NvimTree",
    "mason",
  }
}
