
return {
    "folke/zen-mode.nvim",
    config = function()
        vim.keymap.set("n", "<leader>zz", function()
            require("zen-mode").setup {
                window = {
                  backdrop = 0.95,
                  width = 120, -- width of the Zen window
                  height = 1, -- height of the Zen window
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
                  kitty = {
                    enabled = true,
                    font = "+6", -- font size
                  },
                },
            }
            require("zen-mode").toggle()
            vim.wo.wrap = false
            vim.wo.number = true
            vim.wo.rnu = true
            ColorMyPencils()
        end)


        vim.keymap.set("n", "<leader>zZ", function()
            require("zen-mode").setup {
                window = {
                    width = 80,
                    options = { }
                },
            }
            require("zen-mode").toggle()
            vim.wo.wrap = false
            vim.wo.number = false
            vim.wo.rnu = false
            vim.opt.colorcolumn = "0"
            ColorMyPencils()
        end)
    end
}


