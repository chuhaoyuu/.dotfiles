vim.g.mapleader = " "

local keymap_opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("n", "go", "`[v`]", keymap_opts)
keymap("i", "<C-c>", "<Esc>", keymap_opts)

keymap("n", "J", "mzJ`z", keymap_opts)
keymap("n", "n", "nzzzv", keymap_opts)
keymap("n", "N", "Nzzzv", keymap_opts)

-- Better window movement
keymap("n", "<C-h>", "<C-w>h", keymap_opts)
keymap("n", "<C-j>", "<C-w>j", keymap_opts)
keymap("n", "<C-k>", "<C-w>k", keymap_opts)
keymap("n", "<C-l>", "<C-w>l", keymap_opts)

-- Better indenting
keymap("v", "<", "<gv", keymap_opts)
keymap("v", ">", ">gv", keymap_opts)

keymap("n", "<C-p>", "\"0P", keymap_opts)
keymap("x", "<C-p>", "\"_dP", keymap_opts)
keymap("n", "<space>d", "\"_d", keymap_opts)
keymap("v", "<space>d", "\"_d", keymap_opts)

keymap("n", "<space>y", "\"+y", keymap_opts)
keymap("v", "<space>y", "\"+y", keymap_opts)
keymap("n", "<space>Y", "\"+Y", keymap_opts)

keymap("n", "<space>u", "<cmd>UndotreeToggle<CR>", keymap_opts)

-- Navigate buffers
keymap("n", "<space>]", ":bnext<cr>", keymap_opts)
keymap("n", "<space>[", ":bprevious<cr>", keymap_opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", keymap_opts)
keymap("n", "<C-Down>", ":resize -2<CR>", keymap_opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", keymap_opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", keymap_opts)
-- Move text up and down
-- keymap("v", "<C-j>", ":m .+1<CR>==", keymap_opts)
-- keymap("v", "<C-k>", ":m .-2<CR>==", keymap_opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv=gv", keymap_opts)
keymap("x", "K", ":move '<-2<CR>gv=gv", keymap_opts)

-- grep move
keymap("n", "<C-n>", "<cmd>cnext<CR>zz", keymap_opts)
keymap("n", "<C-p>", "<cmd>cprev<CR>zz", keymap_opts)

keymap("n", "<C-d>", "<C-d>zz", keymap_opts)
keymap("n", "<C-u>", "<C-u>zz", keymap_opts)

-- yaml fold
keymap("n", "<backspace>", "<cmd>foldclose<CR>", keymap_opts)
vim.cmd [[ set foldlevel=99 ]]

keymap("n", "<space>e", ":Rex<CR>", keymap_opts)

keymap("n", "<space>zz", ":ZenMode<CR>", keymap_opts)

vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- yaml fold
vim.keymap.set("n", "<backspace>", "<cmd>foldclose<CR>", keymap_opts)
vim.cmd [[ set foldlevel=99 ]]

vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader>p", ":Telescope find_files<cr>")
vim.keymap.set("n", "<leader>f", ":Telescope live_grep theme=ivy<cr>")
-- git --
vim.keymap.set("n", "<leader>go", ":Telescope git_status<cr>")
vim.keymap.set("n", "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>")
vim.keymap.set("n", "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>")
vim.keymap.set("n", "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>")
vim.keymap.set("n", "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>")
vim.keymap.set("n", "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>")
vim.keymap.set("n", "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>")
vim.keymap.set("n", "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>")
vim.keymap.set("n", "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>")
vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>")
vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>")

vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end)
