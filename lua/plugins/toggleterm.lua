return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = { "<C-/>" },
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<C-/>]],
      direction = "tab",
      size = 30,
      persist_mode = true,
      close_on_exit = false,
      start_in_insert = true,
    })

    -- lazygit in a float so it doesn't touch the layout
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      direction = "float",
      float_opts = { border = "rounded" },
      on_open = function(term)
        vim.keymap.set("t", "<Esc>", "<Esc>", { buffer = term.bufnr })
      end,
    })

    vim.keymap.set("n", "<leader>gg", function() lazygit:toggle() end, { desc = "Lazygit" })
  end,
}