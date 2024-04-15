return { "theprimeagen/harpoon",
  config = function()

    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    vim.keymap.set("n", "<space>a", mark.add_file)
    vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

    vim.keymap.set("n", "<space>1", function() ui.nav_file(1) end)
    vim.keymap.set("n", "<space>2", function() ui.nav_file(2) end)
    vim.keymap.set("n", "<space>3", function() ui.nav_file(3) end)
    vim.keymap.set("n", "<space>4", function() ui.nav_file(4) end)
  end
}
