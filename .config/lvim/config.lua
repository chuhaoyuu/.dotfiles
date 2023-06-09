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
    autocmd InsertEnter * if &filetype == "python" | setlocal colorcolumn=120 | endif
    autocmd InsertEnter * if &filetype == "go" | setlocal colorcolumn=80 | endif
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

lvim.log.level = "error"
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
keymap("n", "go", "`[v`]", keymap_opts)

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

keymap("n", "<space>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], keymap_opts)
keymap("n", "<space>e", ":Rex<CR>", keymap_opts)

keymap("n", "<space>zz", ":ZenMode<CR>", keymap_opts)

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope = {
  active = true,
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      prompt_position = "top",
      width = 0.85,
      preview_cutoff = 120,
      horizontal = {
        preview_width = function(_, cols, _)
          if cols < 120 then
            return math.floor(cols * 0.5)
          end
          return math.floor(cols * 0.6)
        end,
        mirror = false,
      },
      vertical = { mirror = false },
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--glob=!.git/",
    },
    ---@usage Mappings are fully customizable. Many familiar mapping patterns are setup as defaults.
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default + actions.center
      },
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<esc>"] = actions.close,
      },
    },
    file_ignore_patterns = {
      ".git/",
      "__pycache__/*",
      "%.ipynb",
      "node_modules/*",
      ".vscode/",
      "__pycache__/",
      "%.tar",
      "%.zip",
      "%.jar",
      "%.tar.gz",
      "%.deb",
      "%.cache",
      "%.pickle",
      "%.lock",
    },
    path_display = { truncate = 2 },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    use_less = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
    file_sorter = require'telescope.sorters'.get_fuzzy_file,
    generic_sorter =require'telescope.sorters'.get_generic_fuzzy_sorter,
  }
}

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.setup.window['border'] = 'none'
lvim.builtin.which_key.setup.plugins.marks = false
lvim.builtin.which_key.setup.plugins.registers = false
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["p"] = { ":Telescope find_files<cr>", "Find Files" }
lvim.builtin.which_key.mappings["f"] = { ":Telescope live_grep theme=ivy<cr>", "Live Grep" }
-- lvim.builtin.which_key.mappings["x"] = { ":bdelete<cr>", "Close buffer" }


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
lvim.builtin.terminal.active = true
lvim.builtin.autopairs.active = false
lvim.builtin.bufferline.active = false
lvim.builtin.indentlines.active = false
lvim.builtin.alpha.active = false
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.project.active = false
lvim.builtin.dap.active = false
lvim.builtin.illuminate.active = false
lvim.builtin.breadcrumbs.active = false
lvim.builtin.lir.active = false
lvim.builtin.nvimtree.active = false
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.filters.custom = { "node_modules", "\\.cache", "__pycache__" }

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
  "dockerfile",
  "go"
}

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
local cmp = require("cmp")
lvim.builtin.cmp.mapping = cmp.mapping.preset.insert({
  ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
  ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
  ['<C-u>'] = cmp.mapping.scroll_docs(-4),
  ['<C-d>'] = cmp.mapping.scroll_docs(4),
  ['<C-y>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
  ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
  ['<Tab>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
  ['<C-e>'] = cmp.mapping.complete(),
})
table.insert(lvim.builtin.cmp.sources, { name = 'nvim_lsp_signature_help' })
lvim.builtin.cmp.experimental.ghost_text = false
lvim.builtin.cmp.formatting.fields = { 'kind', 'abbr' }

-- lualine
local components = require("lvim.core.lualine.components")
lvim.builtin.lualine.sections.lualine_a = { components.filename }
lvim.builtin.lualine.sections.lualine_b = { components.branch }
lvim.builtin.lualine.sections.lualine_x = {
  components.diagnostics,
  components.lsp,
  -- components.spaces,
  components.treesitter,
  components.filetype
}
lvim.builtin.lualine.sections.lualine_y = { "" }


-- bufferline
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
lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- require("lvim.lsp.manager").setup("pyright", opts)
local ansible_opts = {}
require("lvim.lsp.manager").setup("ansiblels", ansible_opts)

local go_opts = {
  cmd = {'gopls'},
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  },
  init_options = {
    usePlaceholders = false,
  }
}
require("lvim.lsp.manager").setup("gopls", go_opts)


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
-- lvim.lsp.diagnostics.virtual_text = true
vim.diagnostic.config({ virtual_text = true })
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" }, extra_args = {"--line-length", "120", "--skip-string-normalization"} },
  -- { command = "yapf", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" } },
  -- { command = "yamlfmt", filetypes = { "yaml", "yaml.ansible" } },
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
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8", filetypes = { "python" } },
  -- { command = "yamllint", filetypes = { "yaml", "yaml.ansible" } },
  --   {
  --     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
  --     command = "shellcheck",
  --     ---@usage arguments to pass to the formatter
  --     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
  --     extra_args = { "--severity", "warning" },
  --   },
  {
    command = "codespell",
    --     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    --     filetypes = { "javascript", "python" },
  },
}

-- Additional Plugins
lvim.plugins = {
  { 'nvim-treesitter/nvim-treesitter-context', commit = 'e1dc868' },
  { 'gpanders/editorconfig.nvim' },
  { 'theprimeagen/harpoon' },
  { 'mbbill/undotree' },
  { 'tpope/vim-surround' },
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-repeat' },
  { 'towolf/vim-helm' },
  { 'hrsh7th/cmp-nvim-lsp-signature-help' },
  -- { 'folke/tokyonight.nvim', commit = '3ebc29d' },
  { 'nvim-treesitter/nvim-treesitter-textobjects', commit = 'b062311' },
  { 'pedrohdz/vim-yaml-folds' },
  { 'fatih/vim-go', build = ":GoUpdateBinaries" },
  { 'windwp/nvim-ts-autotag',
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  { 'folke/zen-mode.nvim' },
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
require("zen-mode").setup({
  window = {
    backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    -- height and width can be:
    -- * an absolute number of cells when > 1
    -- * a percentage of the width / height of the editor when <= 1
    -- * a function that returns the width or the height
    width = 130, -- width of the Zen window
    height = 1, -- height of the Zen window
    -- by default, no options are changed for the Zen window
    -- uncomment any of the options below, or add other vim.wo options you want to apply
    options = {
      -- signcolumn = "no", -- disable signcolumn
      -- number = false, -- disable number column
      -- relativenumber = false, -- disable relative numbers
      -- cursorline = false, -- disable cursorline
      -- cursorcolumn = false, -- disable cursor column
      -- foldcolumn = "0", -- disable fold column
      -- list = false, -- disable whitespace characters
    },
  },
  plugins = {
    -- disable some global vim options (vim.o...)
    -- comment the lines to not apply the options
    options = {
      enabled = true,
      ruler = false, -- disables the ruler text in the cmd line area
      showcmd = false, -- disables the command in the last line of the screen
    },
    twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
    gitsigns = { enabled = false }, -- disables git signs
    tmux = { enabled = false }, -- disables the tmux statusline
    -- this will change the font size on alacritty when in zen mode
    -- requires  Alacritty Version 0.10.0 or higher
    -- uses `alacritty msg` subcommand to change font size
    alacritty = {
      enabled = true,
      font = "22", -- font size
    },
  },
  -- callback where you can add custom code when the Zen window opens
  on_open = function()
  end,
  -- callback where you can add custom code when the Zen window closes
  on_close = function()
  end,
})

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

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<space>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
