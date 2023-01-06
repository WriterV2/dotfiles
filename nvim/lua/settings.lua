vim.cmd("colorscheme dogrun")
vim.opt.encoding       = "utf-8"
vim.opt.relativenumber = true
vim.opt.laststatus     = 2
vim.opt.autoindent     = true
vim.opt.shiftwidth     = 4
vim.opt.softtabstop    = 4
vim.opt.expandtab      = true
vim.opt.linebreak      = true
vim.opt.termguicolors  = true
vim.opt.completeopt    = { "menuone", "noinsert", "noselect" }
vim.opt.statusline     = "%=  %f  %= "
vim.opt.cursorline     = true
vim.cmd("highlight clear CursorLine")
