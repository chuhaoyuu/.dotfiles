vim.opt.showmode = true
vim.opt.showtabline = 0
vim.opt.guicursor = ""
vim.opt.clipboard = ""
vim.opt.cmdheight = 1
vim.opt.mouse = ""
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.backup = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true


vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.cmd [[
  augroup ColorcolumnOnlyInInsertMode
    autocmd!
    autocmd InsertEnter * if &filetype == "python" | setlocal colorcolumn=120 | endif
    autocmd InsertEnter * if &filetype == "go" | setlocal colorcolumn=120 | endif
    autocmd InsertLeave * setlocal colorcolumn=0
  augroup END
]]

vim.cmd [[
  augroup ansible_filetype
    autocmd!
    autocmd BufNewFile,BufRead */playbooks/*.yml setfiletype yaml.ansible
    autocmd BufNewFile,BufRead */roles/*.yml setfiletype yaml.ansible
    autocmd BufNewFile,BufRead */molecule/*.yml setfiletype yaml.ansible
  augroup END
]]

vim.api.nvim_exec([[
  augroup MyColors
    autocmd!
    autocmd ColorScheme * highlight LineNr guifg=#737aa2
    autocmd ColorScheme * highlight CursorLineNR guifg=#38ff9c
    autocmd ColorScheme * highlight CursorLine guibg=None
    autocmd ColorScheme * highlight TreesitterContext guibg=None
  augroup END
]], false)
