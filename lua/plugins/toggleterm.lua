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
  end,
}