vim.opt.guicursor = ''
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.wrap = false
vim.opt.textwidth = 0
vim.opt.colorcolumn = ''

vim.opt.signcolumn = 'no'
vim.opt.isfname:append '@-@'

vim.opt.updatetime = 50

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
