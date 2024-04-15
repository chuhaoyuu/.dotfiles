return {
  "nvim-telescope/telescope.nvim",

  tag = "0.1.5",

  dependencies = {
    "nvim-lua/plenary.nvim"
  },

  config = function()
    local _, actions = pcall(require, "telescope.actions")
    local _, builtin = pcall(require, "telescope.builtin")
    require('telescope').setup {
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
        file_previewer = require 'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require 'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require 'telescope.previewers'.vim_buffer_qflist.new,
        buffer_previewer_maker = require 'telescope.previewers'.buffer_previewer_maker,
        file_sorter = require 'telescope.sorters'.get_fuzzy_file,
        generic_sorter = require 'telescope.sorters'.get_generic_fuzzy_sorter,
      }
    }
    vim.keymap.set('n', '<leader>p', builtin.find_files, {})
    vim.keymap.set("n", "<leader>f", ":Telescope live_grep theme=ivy<cr>")
    -- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
    vim.keymap.set('n', '<leader>w', function()
      local word = vim.fn.expand("<cword>")
      builtin.grep_string({ search = word })
    end)
    vim.keymap.set('n', '<leader>W', function()
      local word = vim.fn.expand("<cWORD>")
      builtin.grep_string({ search = word })
    end)
  end
}
