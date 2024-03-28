return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        json = { "prettier" },
        yaml = { "prettier" },
        python = { "isort", "black" },
      },
      formatters = {
        black = {
          prepend_args = { "--fast", "--line-length", "120", "--skip-string-normalization" },
        },
      }
    })
    vim.keymap.set({ "n", "v" }, "<leader>lf", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
