--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
vim.opt.showtabline = 0
vim.opt.guicursor = ""
vim.opt.updatetime = 50
vim.opt.clipboard = ""
vim.opt.cmdheight = 1
vim.opt.mouse = ""
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.cmd [[
        augroup ColorcolumnOnlyInInsertMode
          autocmd!
          autocmd InsertEnter * if &filetype == "python" | setlocal colorcolumn=119 | endif
          autocmd InsertLeave * setlocal colorcolumn=0
        augroup END
]]

lvim.log.level = "warn"
lvim.format_on_save = false
lvim.relativenumber = true
lvim.transparent_window = true
lvim.colorscheme = "tokyonight"
lvim.lsp.document_highlight = false
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["H"] = "H"
lvim.keys.normal_mode["L"] = "L"

-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )
local keymap_opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("n", "g0", "`[v`]", keymap_opts)

keymap("n", "J", "mzJ`z", keymap_opts)
keymap("n", "n", "nzzzv", keymap_opts)
keymap("n", "N", "Nzzzv", keymap_opts)

keymap("n", "<C-p>", "\"0P", keymap_opts)
keymap("x", "<C-p>", "\"_dP", keymap_opts)
keymap("n", "<space>d", "\"_d", keymap_opts)
keymap("v", "<space>d", "\"_d", keymap_opts)

keymap("n", "<space>y", "\"+y", keymap_opts)
keymap("v", "<space>y", "\"+y", keymap_opts)
keymap("n", "<space>Y", "\"+Y", keymap_opts)

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
keymap("n", "<C-j>", "<cmd>cnext<CR>zz", keymap_opts)
keymap("n", "<C-k>", "<cmd>cprev<CR>zz", keymap_opts)

keymap("n", "<C-d>", "<C-d>zz", keymap_opts)
keymap("n", "<C-u>", "<C-u>zz", keymap_opts)

-- yaml fold
keymap("n", "<backspace>", "<cmd>foldclose<CR>", keymap_opts)
vim.cmd [[ set foldlevel=99 ]]

keymap("n", "<C-e>", ":Rex<CR>", keymap_opts)
keymap("n", "<space>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], keymap_opts)
-- :E :Ex
lvim.builtin.nvimtree.setup.disable_netrw = false

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.file_ignore_patterns = { "__pycache__", "%.lock", ".git/" }
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
    ["<esc>"] = actions.close,

  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.setup.plugins.marks = false
lvim.builtin.which_key.setup.plugins.registers = false
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["p"] = { ":Telescope find_files<cr>", "Find Files" }
lvim.builtin.which_key.mappings["f"] = { ":Telescope live_grep theme=ivy<cr>", "Live Grep" }
lvim.builtin.which_key.mappings["x"] = { ":bdelete<cr>", "Close buffer" }


-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = false
lvim.builtin.terminal.active = false
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.autopairs.active = false
lvim.builtin.treesitter.autotag.enable = true
lvim.builtin.treesitter.textobjects.select.enable = true
lvim.builtin.treesitter.textobjects.select.lookahead = true
lvim.builtin.treesitter.textobjects.select.keymaps = {
  ["a,"] = "@call.outer",
  ["i,"] = "@call.inner",
  ["aC"] = "@class.outer",
  ["iC"] = "@class.inner",
  ["ac"] = "@conditional.outer",
  ["ic"] = "@conditional.inner",
  ["af"] = "@function.outer",
  ["if"] = "@function.inner",
  ["al"] = "@loop.outer",
  ["il"] = "@loop.inner",
  ["aa"] = "@parameter.outer",
  ["ia"] = "@parameter.inner"
}

-- require('lspkind').init({
--   symbol_map = {
--     Interface = "ﴯ",
--     Class = "",
--     Method = "",
--     Module = "",
--     Text = "",
--     Property = "ﰠ",
--     Variable = "",
--     Function = "",
--     Constructor = "",
--     Field = "",
--     Unit = "塞",
--     Value = "",
--     Enum = "",
--     Keyword = "",
--     Snippet = "",
--     Color = "",
--     File = "",
--     Reference = "",
--     Folder = "",
--     EnumMember = "",
--     Constant = "",
--     Struct = "פּ",
--     Event = "",
--     Operator = "",
--     TypeParameter = "",
--   },
-- })

-- vscode like cmp format
-- local lspkind = require('lspkind')
-- lvim.builtin.cmp.formatting = {
--   fields = { 'abbr', 'kind' },
--   format = lspkind.cmp_format({ with_text = true, maxwidth = 50 }),
--   duplicates = {
--     buffer = 1,
--     path = 1,
--     nvim_lsp = 0,
--     luasnip = 1,
--   },
--   duplicates_default = 0,
-- }
lvim.builtin.cmp.experimental.ghost_text = false
lvim.builtin.cmp.formatting.fields = { 'kind', 'abbr' }
lvim.builtin.cmp.formatting.kind_icons = {
  Interface = "ﴯ ",
  Class = " ",
  Method = " ",
  Module = " ",
  Text = " ",
  Property = "ﰠ ",
  Variable = " ",
  Function = " ",
  Constructor = " ",
  Field = " ",
  Unit = "塞 ",
  Value = " ",
  Enum = " ",
  Keyword = " ",
  Snippet = " ",
  Color = " ",
  File = " ",
  Reference = " ",
  Folder = " ",
  EnumMember = " ",
  Constant = " ",
  Struct = "פּ ",
  Event = " ",
  Operator = " ",
  TypeParameter = " ",

}


-- bufferline
lvim.builtin.bufferline.active = false
lvim.builtin.bufferline.options.buffer_close_icon = ""
lvim.builtin.bufferline.options.close_icon = ""
lvim.builtin.bufferline.options.always_show_bufferline = false
lvim.builtin.bufferline.options.max_name_length = 30
lvim.builtin.bufferline.options.max_prefix_length = 30
lvim.builtin.bufferline.options.tab_size = 21
lvim.builtin.bufferline.highlights.separator = {
  fg = { attribute = "bg", highlight = "TabLine" },
  bg = { attribute = "bg", highlight = "TabLine" },
}
lvim.builtin.bufferline.highlights.indicator_selected = {
  fg = { attribute = "fg", highlight = "LspDiagnosticsDefaultHint" },
  bg = { attribute = "bg", highlight = "Normal" },
}
lvim.builtin.bufferline.options.offsets = {
  {
    filetype = "undotree",
    text = "Undotree",
    -- highlight = "PanelHeading",
    padding = 1,
  },
  {
    filetype = "NvimTree",
    text = "",
    -- highlight = "PanelHeading",
    padding = 1,
  },
  {
    filetype = "DiffviewFiles",
    text = "Diff View",
    -- highlight = "PanelHeading",
    padding = 1,
  },
  {
    filetype = "flutterToolsOutline",
    text = "Flutter Outline",
    -- highlight = "PanelHeading",
  },
  {
    filetype = "packer",
    text = "Packer",
    -- highlight = "PanelHeading",
    padding = 1,
  },
}
-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumeko_lua",
--     "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
lvim.lsp.diagnostics.virtual_text = true
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "yapf", filetypes = { "python" } },
  --   { command = "isort", filetypes = { "python" } },
  --   {
  --     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
  --     command = "prettier",
  --     ---@usage arguments to pass to the formatter
  --     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
  --     extra_args = { "--print-with", "100" },
  --     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
  --     filetypes = { "typescript", "typescriptreact" },
  --   },
}

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
lvim.plugins = {
  { "folke/tokyonight.nvim", commit = 'c78e698' },
  { "tpope/vim-surround" },
  -- { "karb94/neoscroll.nvim", require('neoscroll').setup() },
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  {
    "lukas-reineke/indent-blankline.nvim",
    setup = function()
      vim.g.indent_blankline_char = "▏"
    end,
    config = function()
      require("indent_blankline").setup {
        enabled = true,
        bufname_exclude = { "README.md" },
        buftype_exclude = { "terminal", "nofile" },
        filetype_exclude = {
          "alpha",
          "log",
          "gitcommit",
          "dapui_scopes",
          "dapui_stacks",
          "dapui_watches",
          "dapui_breakpoints",
          "dapui_hover",
          "LuaTree",
          "dbui",
          "UltestSummary",
          "UltestOutput",
          "vimwiki",
          "markdown",
          "json",
          "txt",
          "vista",
          "NvimTree",
          "git",
          "TelescopePrompt",
          "undotree",
          "flutterToolsOutline",
          "org",
          "orgagenda",
          "help",
          "startify",
          "dashboard",
          "packer",
          "neogitstatus",
          "NvimTree",
          "Outline",
          "Trouble",
          "lspinfo",
          "", -- for all buffers without a file type
        },
        show_trailing_blankline_indent = false,
        show_first_indent_level = false,
        space_char_blankline = " ",
        use_treesitter = true,
        show_foldtext = false,
        show_current_context = true,
        show_current_context_start = false,
        context_patterns = {
          "class",
          "return",
          "function",
          "method",
          "^if",
          "^do",
          "^switch",
          "^while",
          "jsx_element",
          "^for",
          "^object",
          "^table",
          "block",
          "arguments",
          "if_statement",
          "else_clause",
          "jsx_element",
          "jsx_self_closing_element",
          "try_statement",
          "catch_clause",
          "import_statement",
          "operation_type",
        },
      }
    end,
    -- event = "BufRead",
  },
  { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' },
  { 'pedrohdz/vim-yaml-folds' },
  { 'windwp/nvim-ts-autotag',
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  -- { 'onsails/lspkind.nvim' },
  --     {
  --       "folke/trouble.nvim",
  --       cmd = "TroubleToggle",
  --     },
}
-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })

require("tokyonight").setup({
    style = "night",
    transparent = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      functions = {},
      variables = {},
      sidebars = "transparent",
      floats = "transparent",
    },
    sidebars = {
      "qf",
      "vista_kind",
      "terminal",
      "packer",
      "spectre_panel",
      "NeogitStatus",
      "help",
    },
    day_brightness = 0.3,
    hide_inactive_statusline = false,
    dim_inactive = false,
    lualine_bold = false,
    on_highlights = function(hl, c)
      hl.IndentBlanklineContextChar = {
        fg = c.dark5,
      }
      hl.TSConstructor = {
        fg = c.blue1,
      }
      hl.TSTagDelimiter = {
        fg = c.dark5,
      }
    end,
})
