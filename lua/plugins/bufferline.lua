return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    options = {
      separator_style = "slant",
      show_buffer_close_icons = true,
      show_close_icon = false,
      diagnostics = "nvim_lsp", -- shows error count on tab
    },
  },
}